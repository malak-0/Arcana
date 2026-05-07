from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Arcana Backend Running"}

from Backend.routes.upload import router as upload_router
from Backend.routes.chat import router as chat_router
from Backend.routes.summary import router as summary_router

app.include_router(upload_router)
app.include_router(chat_router)
app.include_router(summary_router)