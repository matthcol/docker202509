docker volume create mariadbmovie-data
docker run --name mariadbmovie `
    -e MARIADB_ROOT_PASSWORD=mysuperpassword `
    -e MARIADB_USER=movie `
    -e MARIADB_PASSWORD=mysuperpassword `
    -e MARIADB_DATABASE=dbmovie `
    -v "$(pwd)/sql-dbmovie-mariadb:/docker-entrypoint-initdb.d" `
    -v mariadbmovie-data:/var/lib/mysql `
    -d mariadb:12