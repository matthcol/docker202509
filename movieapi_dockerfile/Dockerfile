FROM python:3.13-bookworm

# TODO: recopier le code de l'application dans l'image
# - V0 : lancer un bash et vérifier que l'application est bien copiée

WORKDIR /src

COPY src/movieapi movieapi

# - V1 : prevoir les variables d'environnement:
#    * DATABASE_URL à "sqlite:///./test.db"
#    * DDL_AUTO à "create"
ENV DATABASE_URL="sqlite:///./test.db"
ENV DDL_AUTO=create
ENV DB_DRIVER=''

# - v2 : installer les dépendances Python:
#   * pip install -r requirements.txt

COPY requirements.txt .

RUN pip install -r requirements.txt --root-user-action=ignore

RUN set -eux; \
    apt update; \
    apt install -y iproute2

# - v3 : lancer l'API
#   * uvicorn movieapi.main:app --host 0.0.0.0 --port 8000

# CMD ["uvicorn", "movieapi.main:app", "--host", "0.0.0.0", "--port", "8000"]

COPY docker-entrypoint.sh .

ENTRYPOINT [ "./docker-entrypoint.sh" ]

