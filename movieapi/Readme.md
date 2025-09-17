
Construire une image (avec ou sans cache):
```
docker build -t movieapi:0.1 .
docker image ls

docker build --no-cache -t movieapi:0.1 .
```

Utiliser l'image:
```
docker run -it --rm movieapi:0.1        # default python
docker run -it --rm movieapi:0.1 bash
```

```
docker run -it --rm movieapi:0.2        # default bash
docker run -it --rm movieapi:0.2 python
```

```
docker run -it --rm movieapi:0.3       
env | grep "^DB_"

docker run -it --rm `
    -e DB_HOST=192.168.5.2 `
    -e DB_USER=movie `
    movieapi:0.3       
env | grep "^DB_"

```

Conseil lecture: ARG vs ENV
https://www.docker.com/blog/docker-best-practices-using-arg-and-env-in-your-dockerfiles/