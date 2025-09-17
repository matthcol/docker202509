## Environnement
DATABASE_URL : les infos de connexion
DDL_AUTO : none, create, drop

Exemple DATABASE_URL:
- mariadb+mariadbconnector://app_user:Password123!@127.0.0.1:3306/company
- par défaut utilise Sqlite

## Version 0
```
docker build -t movieapi:0.0 .  
docker run -it --rm movieapi:0.0
ls /src/movieapi
```

## Version 1
```
docker build -t movieapi:0.1 .  
docker run -it --rm movieapi:0.1
env     # check les valeurs de DATABASE_URL, DDL_AUTO

docker run -it --rm -e DATABASE_URL=url_bidon -e DDL_AUTO=none movieapi:0.1
env     # check les valeurs de DATABASE_URL, DDL_AUTO
```

## Version 3
```
docker build -t movieapi:0.3 .  
docker run -d --name movieapi -p 8000:8000 movieapi:0.3

# checkup
docker ps -a
docker logs movieapi
docker exec -it movieapi bash
ps -aef | grep uvicorn
ss -plantu
curl localhost:8000/movies/
curl localhost:8000/docs
```

## Connexion de réseaux
Le conteneur api doit rejoindre le réseau docker de la base MariaDB movie.

```
docker network ls
docker inspect mariadbmovie-db-1
docker inspect --format '{{json .NetworkSettings.Networks}}' mariadbmovie-db-1
docker network inspect mariadbmovie_default

# lancer l'api en mode provisoire
docker run -it --name movieapi -p 8000:8000 --network mariadbmovie_default movieapi:0.3 bash
pip install pymysql
export DATABASE_URL=mysql+pymysql://movie:mysuperpassword@db/dbmovie
export DDL_AUTO=none
uvicorn movieapi.main:app --host 0.0.0.0 --port 8000

# en //
docker inspect movieapi
```

## Version avec driver DB adaptatif

Image adaptative: 0.4
```
docker build -t movieapi:0.4 .
```


Avec SqlLite:
```
docker run -d `
    --name movieapi-lite `
    -p 8000:8000 `
    movieapi:0.4
```

Avec MariaDB:
```
docker run -d `
    --name movieapi-maria `
    -p 8001:8000 `
    --network mariadbmovie_default `
    -e DATABASE_URL=mysql+pymysql://movie:mysuperpassword@db/dbmovie `
    -e DDL_AUTO=none `
    -e DB_DRIVER=pymysql `
    movieapi:0.4
```

Avec PostgreSQL:
```
docker run -d `
    --name movieapi-pg `
    -p 8002:8000 `
    -e DATABASE_URL=postgresql+psycopg2://movie:mysecretpassword@pgdbmovie/dbmovie `
    -e DDL_AUTO=none `
    -e DB_DRIVER=psycopg2-binary `
    --network moviepg_default `
    movieapi:0.4
```

## Connecter un conteneur à un réseau à postériori

```
docker network create moviepg_ext
docker network connect moviepg_ext movieapi-pg
docker inspect movieapi-pg
```