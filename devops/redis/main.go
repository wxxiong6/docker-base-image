package main

import (
	"context"
	"flag"
	"fmt"
	"github.com/redis/go-redis/v9"
	"log"
	"math/rand"
	"net/url"
	"os"
	"regexp"
	"strings"
	"sync"
	"time"
)

func main() {
	s := time.Now()
	wg := sync.WaitGroup{}
	wg.Add(1)
	ctx, cancel := context.WithCancel(context.Background())

	var keysChan = make(chan []string, 1000)
	redisUrl := flag.String("addr", "redis://:localhost:6379/0", "redis ParseURL redis://<user>:<pass>@localhost:6379/<db>")
	isOutput := flag.Bool("isOutput", true, "Output results to filename")
	filename := flag.String("filename", fmt.Sprintf("%s/keys.txt", os.Getenv("HOME")), "output filename")
	interval := flag.Duration("interval", time.Millisecond*50, "interval between refresh Millisecond")
	expire := flag.Duration("expire", 10*time.Minute, "default set ttl")
	matchKey := flag.String("match", "disguise_statu*", "redis match key")
	flag.Parse()
	if *redisUrl == "" {
		flag.Usage()
		os.Exit(1)
	}

	var f *os.File
	var err error
	if *isOutput {
		if checkFileIsExist(*filename) { //如果文件存在
			f, err = os.OpenFile(*filename, os.O_APPEND|os.O_WRONLY, os.ModeAppend) //打开文件
			fmt.Println("The file exists", *filename)
			check(err)
		} else {
			f, err = os.Create(*filename) //创建文件
			fmt.Println("The file does not exist, create the file", *filename)
			check(err)
		}
		defer func(f *os.File) {
			err := f.Close()
			if err != nil {
				check(err)
			}
		}(f)
		check(err)
	}

	escapeRedisUlr, err := urlParse(*redisUrl)
	check(err)
	opt, err := redis.ParseURL(escapeRedisUlr)
	check(err)

	rdb := redis.NewClient(opt)
	defer func(rdb *redis.Client) {
		err := rdb.Close()
		if err != nil {
			fmt.Println("redis close err:", err)
		}
	}(rdb)
	result, err := rdb.Ping(ctx).Result()
	check(err)
	fmt.Println("redis ping result:", result)

	go func(ctx context.Context) {
		for {
			select {
			case <-ctx.Done():
				fmt.Println("goroutine done")
				wg.Done()
				return
			case key, ok := <-keysChan:
				if !ok {
					fmt.Println("There is no data")
					return
				}
				wg2 := sync.WaitGroup{}

				go func() {
					wg2.Add(1)
					defer wg2.Done()
					if *isOutput {
						s := strings.Join(key, "\n")
						writeString, err := f.WriteString(fmt.Sprintln(s))
						check(err)
						fmt.Println(writeString)
					}
				}()

				go func() {
					wg2.Add(1)
					defer wg2.Done()
					if *expire > -1 && len(key) > 0 {
						pipeline := rdb.Pipeline()
						t := *expire + time.Duration(60+rand.Intn(540))*time.Second
						for _, k := range key {
							pipeline.Expire(ctx, k, t)
						}
						_, err := pipeline.Exec(ctx)
						check(err)
					}
				}()
			
				wg2.Wait()

			}
		}
	}(ctx)

	var cursor uint64 = 0
	//var match string = "test*"
	var match string = *matchKey
	var count int64 = 1000
	//var notTTLKeys []string
	// 扫描数量
	var scanKeysNum uint64
	// 未设置expire 数量
	var notTTLKeysSize uint64
	for {
		keys, cur, err := rdb.Scan(ctx, cursor, match, count).Result()
		check(err)

		if len(keys) == 0 {
			continue
		}

		pipeline := rdb.Pipeline()
		for _, key := range keys {
			scanKeysNum += 1
			pipeline.TTL(ctx, key)
		}

		exec, err := pipeline.Exec(ctx)
		check(err)

		var notTTLKeys []string
		for _, exec := range exec {
			if exec.Err() != nil {
				continue
			}
			if exec.(*redis.DurationCmd).Val() == -1 {
				c := exec.Args()
				notTTLKeys = append(notTTLKeys, c[1].(string))
				notTTLKeysSize += 1
			}
		}

		if len(notTTLKeys) > 0 {
			keysChan <- notTTLKeys
		}

		cursor = cur

		fmt.Println("cursor:", cur, ", Scan keys ", scanKeysNum, ", find the number of expire not set", notTTLKeysSize)
		time.Sleep(*interval)

		if cur == 0 {
			cancel()
			break
		}
	}
	wg.Wait()
	fmt.Println("SCan Duration：", time.Since(s))
	fmt.Println("system done")
}

func checkFileIsExist(filename string) bool {
	var exist = true
	if _, err := os.Stat(filename); os.IsNotExist(err) {
		exist = false
	}

	return exist
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func urlParse(uri string) (string, error) {
	compile, err := regexp.Compile("//(.*):(.*)@")
	if err != nil {
		return "", err
	}
	submatch := compile.FindAllStringSubmatch(uri, -1)
	if len(submatch) != 1 && len(submatch[0]) != 3 {
		log.Println(submatch)
		return "", err
	}
	username := url.QueryEscape(submatch[0][1])
	password := url.QueryEscape(submatch[0][2])
	uri = strings.ReplaceAll(uri, submatch[0][1], username)
	uri = strings.ReplaceAll(uri, submatch[0][2], password)
	return uri, nil
}

func usage() {
	fmt.Println("Usage: redisTool - addr - isOutput - match -expire")
	os.Exit(0)
}

