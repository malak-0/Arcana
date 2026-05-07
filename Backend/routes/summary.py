from fastapi import APIRouter
from pydantic import BaseModel

from Backend.rag.retriever import get_retriever
from Backend.rag.llm import llm

router = APIRouter()

class SummaryRequest(BaseModel):
    paper_id: str


@router.post("/summarize")
async def summarize(request: SummaryRequest):

    retriever = get_retriever(request.paper_id)

    # ✅ Better modern method
    docs = retriever.invoke("Summarize the key ideas of this research paper")

    if not docs:
        return {
            "summary": "No relevant content found in the paper."
        }

    context = "\n".join(doc.page_content for doc in docs)

    prompt = f"""
You are an expert research assistant.

Summarize the following paper clearly and structured.

Include:
- Objective
- Methodology
- Dataset
- Results
- Limitations

Context:
{context}
"""

    response = llm.invoke(prompt)

    return {
        "summary": response.content
    }