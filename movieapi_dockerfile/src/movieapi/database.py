import os

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker


DATABASE_URL = os.environ.get("DB_URL", "sqlite:///./test.db")
DDL_AUTO = os.environ.get("DDL_AUTO", "none").lower()

engine = create_engine(
    DATABASE_URL,
    echo=True # debug SQL queries
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def init_db():
    """
    Initialise la base selon la valeur de DDL_AUTO :
    - 'create' -> crée les tables si elles n'existent pas
    - 'drop' -> supprime toutes les tables puis les recrée
    - 'none' -> ne fait rien
    """
    match DDL_AUTO:
        case "create":
            Base.metadata.create_all(bind=engine)
            print("Tables créées automatiquement")
        case "drop":
            Base.metadata.drop_all(bind=engine)
            Base.metadata.create_all(bind=engine)
            print("Tables recréées (drop + create)")
        case "none":
            print("Pas de modification automatique du schéma")
        case _:
            raise ValueError(f"Valeur DDL_AUTO invalide : {DDL_AUTO}")
