from fastapi import FastAPI

app = FastAPI()

@app.get("/health")
async def health():
    return {"message": "Healthy"}

@app.get("/version")
async def version():
    return {"message": "v0.1"}