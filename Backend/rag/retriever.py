from langchain_community.vectorstores import Chroma
from Backend.rag.embeddings import embedding_model

def get_retriever(paper_id):

    vectordb = Chroma(
        persist_directory=f"storage/chroma_db/{paper_id}",
        embedding_function=embedding_model,
        collection_name=paper_id
    )

    return vectordb.as_retriever(search_kwargs={"k": 4})