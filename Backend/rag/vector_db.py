from langchain_community.vectorstores import Chroma
from Backend.rag.embeddings import embedding_model

def create_vector_store(chunks, paper_id):

    persist_path = f"storage/chroma_db/{paper_id}"

    vectordb = Chroma.from_texts(
        texts=chunks,
        embedding=embedding_model,
        persist_directory=persist_path,
        collection_name=str(paper_id)
    )

    vectordb.persist()

    return vectordb