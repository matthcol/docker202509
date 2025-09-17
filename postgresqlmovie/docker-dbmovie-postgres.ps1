docker network create moviepg_default 
docker volume create pgdbmovie-data
docker run --name pgdbmovie `
    -e POSTGRES_PASSWORD=mysecretpassword `
    -e POSTGRES_DB=dbmovie `
    -e POSTGRES_USER=movie `
    -v "$(pwd)/sql-dbmovie-pg:/docker-entrypoint-initdb.d" `
    -v pgdbmovie-data:/var/lib/postgresql/data `
    -p 5432:5432 `
    --network moviepg_default `
    -d postgres:17