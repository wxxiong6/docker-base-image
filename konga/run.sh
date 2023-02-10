docker run -p 1337:1337 \
             --network kong-net \
			 --name konga \
             -e "NODE_ENV=development" \
             -e "name=NODE_ENV" \
             -e "name=KONGA_LOG_LEVEL" \
             -e "value=debug"       \
             -e "name=DB_ADAPTER"   \
             -e "value=postgres"    \
             -e "name=DB_URI"       \
             -e "value=postgresql://kong:kongpass@kong-database:5432/postgres?TimeZone=Asia/Shanghai" \
             -e "name=DB_PG_SCHEMA" \
             -e "value=public"      \
             -e "name=NO_AUTH"      \
             -e "value=false"       \
          pantsel/konga
