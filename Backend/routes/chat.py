from fastapi import APIRouter
from pydantic import BaseModel

from Backend.rag.retriever import get_retriever
from Backend.rag.llm import llm

router = APIRouter()

class ChatRequest(BaseModel):
    paper_id: str
    question: str

@router.post("/chat")
async def chat(request: ChatRequest):

    try:
        print("========== CHAT REQUEST ==========")
        print("Paper ID:", request.paper_id)
        print("Question:", request.question)

        retriever = get_retriever(request.paper_id)

        print("Retriever loaded")

        docs = retriever.invoke(request.question)

        print("DOCS FOUND:", len(docs))
        for i, d in enumerate(docs):
            print(f"\nDOC {i}:\n", d.page_content[:300])
        print("Documents retrieved:", len(docs))

        context = "\n".join(
            [doc.page_content for doc in docs]
        )

        print("Context created")

        prompt = f"""
        Answer the question using ONLY the context.If the answer is not in the context, say: "I don't know based on the document."

        Context:
        {context}

        Question:
        {request.question}
        """

        print("Sending to LLM...")

        response = llm.invoke(prompt)

        print("LLM response received")

        return {
            "answer": response.content
        }

    except Exception as e:
        print("========== ERROR ==========")
        print(str(e))

        return {
            "answer": f"Backend Error: {str(e)}"
        }