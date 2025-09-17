# Docker Compose

## Création/Destruction

Création de tous les conteneurs de la compoosition + démarrage.
Création des volumes externes si non existant + réseau propre à la composition.
```
docker compose up -d
```

Destruction de tous les conteneurs de la composition + le réseau. Les volumes persitents ne 
sont pas supprimés.
```
docker compose down
```

NB: si on veut reconstruire entièrement le
conteneur, il faut supprimer le volume:

```
docker compose down
docker volume rm mariadbmovie_mariadbmovie-data
docker up -d
```


## Autres commandes
Valables dans le répertoire de la composition (nom par défaut):
```
docker compose exec -it db bash
docker compose logs db
docker compose stop db
docker compose start db
```

Dans un autre dossier il faut rappeler le nom de la composition (nom du projet):

```
docker compose -p mariadbmovie exec -it db bash
docker compose -p mariadbmovie logs db
docker compose -p mariadbmovie stop db
docker compose -p mariadbmovie start db
```

Inspect uniquement disponible avec docker:
```
docker inspect mariadbmovie-db-1
```

## Variabilisation
Nom de fichier par défaut: .env

NB: pour variabiliser le nom du volume, utiliser la clé `name`.

## Exercice:
Réutiliser le fichier docker-compose.yml pour créer une 2e base sur l'athlé. 

Tip: utiliser les options suivantes:
```
 -p : nom de la composition = nom du projet
 --env-file : fichier de variables si différent de .env
```

```
docker compose -p mariadbathle --env-file .env-athle up -d
docker compose -p mariadbathle ps -a
docker compose -p mariadbathle logs db
docker compose -p mariadbathle exec -it db mariadb -u athle -p  -e "select * from event" dbathle
```


NB: Bonne pratique => Recopier le Yaml dans un nouveau répertoire avec le nom de la composition
et un .env

## Ajout de l'api
Description de l'API dans un 2e Yaml: docker-compose-api.yml

```
docker compose -f docker-compose.yml -f docker-compose-api.yml up -d
```

Voir la composition complète (fusion, override des Yaml + résolution des variables)
```
docker compose -f docker-compose.yml -f docker-compose-api.yml config
```

## Stratégie de (re)démarrage et dépendances entre services:

https://docs.docker.com/engine/containers/start-containers-automatically/

Valeurs de restart: no, always, on-failure[:max-retries], unless-stopped

Dépendances: clé depends_on + healthcheck
