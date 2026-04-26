import os
import psycopg
from fastapi import FastAPI

app = FastAPI()

@app.get("/db-check")
async def db_check():
    # Connect to database:
    db_host = os.getenv("DB_HOST", "db")
    db_port = os.getenv("DB_PORT", "5432")
    db_name = os.getenv("DB_NAME", "appdb")
    db_user = os.getenv("DB_USER", "dbuser")
    db_password = os.getenv("DB_PASS", "dbpass")


    with psycopg.connect(f"host={db_host} port={db_port} dbname={db_name} user={db_user} password={db_password}") as conn:
        with conn.cursor() as cur:
            cur.execute("""
            SELECT 1
            """)
            result = cur.fetchone()
            return {"db_status": "ok", "result": result[0]}

@app.get("/health")
async def health():
    return {"message": "Healthy"}

@app.get("/version")
async def version():
    return {"message": "v0.1"}

@app.get("/config")
async def config():
    db_host = os.getenv("DB_HOST", "db")
    db_port = os.getenv("DB_PORT", "5432")
    db_name = os.getenv("DB_NAME", "appdb")
    return {"db_host": db_host, "db_port": db_port, "db_name": db_name}
