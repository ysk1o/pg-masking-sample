# about
- this is sample code of masking postgres

# create .env file
```
cp .env.sample .env
```

# download sample data

```bash
wget https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip \
  -O postgres/initdb/dvdrental.zip

unzip postgres/initdb/dvdrental.zip -d postgres/initdb

rm postgres/initdb/dvdrental.zip

tar -xvf postgres/initdb/dvdrental.tar -C postgres/initdb

rm postgres/initdb/dvdrental.tar
```

# insert sample data

```bash
docker exec anonymizer sh -c \
  '
    sed -e "s/\$\$PATH\\$\\$/\/tmp\/postgres\/initdb/g" /tmp/postgres/initdb/restore.sql |
    psql \
      --port=$(printenv POSTGRES_PORT) \
      --user=$(printenv POSTGRES_USER) \
      --dbname=$(printenv POSTGRES_DB)
  '
```

# mask data

## enable functions
```bash
docker exec anonymizer sh -c \
  '
    psql \
      --port=$(printenv POSTGRES_PORT) \
      --user=$(printenv POSTGRES_USER) \
      --dbname=$(printenv POSTGRES_DB) \
      -f /tmp/postgres/maskdb/init.sql
  '
```

## mask
```bash
docker exec anonymizer sh -c \
  '
    psql \
      --port=$(printenv POSTGRES_PORT) \
      --user=$(printenv POSTGRES_USER) \
      --dbname=$(printenv POSTGRES_DB) \
      -f /tmp/postgres/maskdb/staff.sql
  '
```

# dump masked data
```bash
docker exec anonymizer sh -c \
  '
    pg_dump_anon.sh \
      --port=$(printenv POSTGRES_PORT) \
      --username=$(printenv POSTGRES_USER) \
      --dbname=$(printenv POSTGRES_DB) \
      > /tmp/postgres/dump/alltables.sql
  '
```
