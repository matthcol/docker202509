from fastapi import FastAPI
from .database import Base, init_db
from .routers import movies

app = FastAPI()

# Créer les tables eventuellement
init_db()

app.include_router(movies.router)
