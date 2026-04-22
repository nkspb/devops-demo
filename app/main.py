from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/health")
async def health():
    return {"message": "Healthy"}

@app.get("/version")
async def version():
    return {"message": "v0.1"}

@app.get("/config")
async def config():
    db_host = os.getenv("DB_HOST")
    db_port = os.getenv("DB_PORT")
    db_name = os.getenv("DB_NAME")
    return {"db_host": db_host, "db_port": db_port, "db_name": db_name}
