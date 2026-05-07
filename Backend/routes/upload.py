from fastapi import APIRouter, UploadFile, File
import shutil
import os
import uuid

router = APIRouter() 

from Backend.rag.extract_text import extract_text
from Backend.rag.chunk_text import split_text
from Backend.rag.vector_db import create_vector_store


@router.post("/upload")
async def upload_pdf(file: UploadFile = File(...)):

    try:
        os.makedirs("storage/papers", exist_ok=True)
        os.makedirs("storage/chroma_db", exist_ok=True)

        file_path = f"storage/papers/{file.filename}"

        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        text = extract_text(file_path)
        print("TEXT LENGTH:", len(text))

        chunks = split_text(text)
        print("CHUNKS:", len(chunks))

        paper_id = str(uuid.uuid4())

        create_vector_store(chunks, paper_id)

        return {
            "message": "PDF processed successfully",
            "paper_id": paper_id
        }

    except Exception as e:
        print(" UPLOAD ERROR:", str(e))
        return {"error": str(e)}