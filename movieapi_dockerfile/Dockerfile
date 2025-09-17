FROM python:3.13-bookworm

# TODO: recopier le code de l'application dans l'image
# - V0 : lancer un bash et vérifier que l'application est bien copiée

COPY src/movieapi /src/movieapi

# - V1 : prevoir les variables d'environnement:
#    * DATABASE_URL à "sqlite:///./test.db"
#    * DDL_AUTO à "create"
ENV DATABASE_URL="sqlite:///./test.db"
ENV DDL_AUTO=create

# - v2 : installer les dépendances Python:
#   * pip install -r requirements.txt

COPY requirements.txt src
WORKDIR /src
RUN pip install -r requirements.txt --root-user-action=ignore

# - v3 : lancer l'API
#   * uvicorn movieapi.main:app --host 0.0.0.0 --port 8000

CMD ["uvicorn", "movieapi.main:app", "--host", "0.0.0.0", "--port", "8000"]

