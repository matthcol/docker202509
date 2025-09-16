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

