FROM python:3.13-bookworm

# commandes faites pendant la construction de l'image
RUN set -eux; \
    apt update; \
    apt install tree psmisc

ENV DB_HOST=localhost
ENV DB_PORT=''
ENV DB_DATABASE=db
ENV DB_USER=''
ENV DB_PASSWORD=''

COPY docker-entrypoint.sh /docker-entrypoint/docker-entrypoint.sh

# commande obligatoire au lancement du conteneur
ENTRYPOINT ["/docker-entrypoint/docker-entrypoint.sh"]

# commande par défaut au lancement du conteneur
# NB: substituable
CMD  ["bash"]