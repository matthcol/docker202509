# Docker

## Commandes de base

### Lister les conteneurs


```
# Voir tous les conteneurs qui tournent
docker ps

# Idem + ceux qui sont arrêtés
docker ps -a
```

### Superviser un conteneur
Avec son ID ou son nom

- Traces:
```
docker logs d2d72dd19ffd
docker logs dbmovie-sqlserver-db-1
```

- Caractéristiques:
```
docker inspect d2d72dd19ffd
docker inspect dbmovie-sqlserver-db-1
```

### Execution dans un conteneur
```
docker exec -it d2d72dd19ffd bash
docker exec -it d2d72dd19ffd ls /opt/mssql/bin
```

### Création conteneur

Mode interactif (-it):
```
docker run -it python:3.13
```

Suppresion auto après exécution (--rm):
```
docker run -it --rm python:3.13
```

### Supprimer un conteneur
Arrêt + suppression ou suppresion forcée:
```
docker stop pensive_hamilton
docker rm pensive_hamilton

docker rm -f peaceful_heyrovsky
```

## Docker BDD

### PostgreSQL
```
docker run --name postgresdb -e POSTGRES_PASSWORD=mysecretpassword -d postgres
docker ps
docker logs postgresdb
docker exec -it postgresdb bash
```

Powershell (continuation de ligne):
```
docker run --name postgresdb2 `
    -e POSTGRES_PASSWORD=mysecretpassword `
    -e POSTGRES_DB=dbmovie `
    -e POSTGRES_USER=movie `
    -d postgres
docker exec -it postgresdb2 bash
psql -U movie -d dbmovie
```

Shell (continuation de ligne):
```
docker run --name postgresdb2 \
    -e POSTGRES_PASSWORD=mysecretpassword \
    -e POSTGRES_DB=dbmovie \
    -e POSTGRES_USER=movie \
    -d postgres
```

## Gestion des images
### Voir les images locales
```
docker image ls
```

### Télécharger une image
```
docker pull postgres:17
docker pull postgres:17.6
docker pull postgres:17-alpine
docker pull postgres:13
```

### Supprimer une image
```
docker image rm postgres:latest
docker image rm postgres:17-alpine
```

### Exercice
Créer 2 bases PostgreSQL: 
- 1 en version 17: dbmovie (user movie)
- 1 en version 13: dbathle (user athle)

```
docker run --name pgdbmovie `
    -e POSTGRES_PASSWORD=mysecretpassword `
    -e POSTGRES_DB=dbmovie `
    -e POSTGRES_USER=movie `
    -d postgres:17

docker run --name pgdbathle `
    -e POSTGRES_PASSWORD=mysecretpassword `
    -e POSTGRES_DB=dbathle `
    -e POSTGRES_USER=athle `
    -d postgres:13

docker ps

docker exec -it pgdbmovie psql -U movie -d dbmovie
docker exec -it pgdbathle psql -U athle -d dbathle

docker exec -it pgdbmovie cat /var/lib/postgresql/data/PG_VERSION
docker exec -it pgdbathle cat /var/lib/postgresql/data/PG_VERSION
```

## Renommage
```
docker rename pgdbathle pgdbathletics
```

## Partage de fichiers hôte <-> conteneur

### Au démarrage : montage

```
docker rm -f pgdbmovie 
docker ps -a
docker run --name pgdbmovie `
    -e POSTGRES_PASSWORD=mysecretpassword `
    -e POSTGRES_DB=dbmovie `
    -e POSTGRES_USER=movie `
    -v "$(pwd)/sql-dbmovie-pg:/docker-entrypoint-initdb.d" `
    -d postgres:17

docker ps
docker logs pgdbmovie
docker exec -it pgdbmovie ls /docker-entrypoint-initdb.d
docker exec -it pgdbmovie psql -U movie -d dbmovie
docker exec -it pgdbmovie psql -U movie -d dbmovie -c "\d"
docker exec -it pgdbmovie psql -U movie -d dbmovie -c "select * from person"
```

## Exercice
Créer une base de données MariaDB avec les scripts: sql-dbmovie-mariadb

```
.\docker-dbmovie-mariadb.ps1

docker exec -it mariadbmovie bash

mariadb -u root -p
show databases;
select host,user from mysql.user;

mariadb -u movie -p dbmovie
show tables;
select * from person limit 10;
```




## Persistence de données et volumes externes
Ajouter de la donnée:
```
docker exec -it mariadbmovie mariadb -u movie -p dbmovie

insert into movie (title, year) values ('West Side Story du Future', 2099);
select title, year from movie where year = 2099;
```

Supprimer et recréer le conteneur:
```
docker stop mariadbmovie
docker rm mariadbmovie
.\docker-dbmovie-mariadb.ps1
```

Check data:
```
docker exec -it mariadbmovie mariadb -u movie -p dbmovie
select title, year from movie where year = 2099;
```

Verdict: on a perdu la data => Recréer le conteneur en passant par un volume externe.


TODO: 


```
docker run -it --rm -v mariadbmovie-data:/data:ro debian:12-slim bash
```

