📚 Arcana — AI Research Paper Assistant

Arcana is an AI-powered research assistant that allows users to upload PDFs, ask questions, and generate intelligent summaries using Retrieval-Augmented Generation (RAG).

It combines a Flutter mobile app with a FastAPI backend powered by vector databases and large language models.

🚀 Features

  📄 Upload and process research papers (PDF)
  
  🧠 AI-powered Q&A over documents (RAG system)
  
  ✍️ Automatic structured paper summarization
  
  🔎 Context-aware retrieval using embeddings
  
  💬 Chat interface with uploaded documents
  
  📱 Cross-platform Flutter mobile application
  
  ⚡ Fast and lightweight backend using FastAPI
  

🏗️ System Architecture

  Flutter App
  
       ↓
       
  FastAPI Backend
       ↓
       
  PDF Processing (PyMuPDF)
  
       ↓
       
  Text Chunking (LangChain)
  
       ↓
       
  Embeddings (HuggingFace BGE)
  
       ↓
       
  Vector Database (ChromaDB)
  
       ↓
       
  LLM (Gemini / Google Generative AI)
  

🧠 How It Works

  User uploads a PDF from the Flutter app
  
  Backend extracts text from the document
  
  Text is split into smaller chunks
  
  Each chunk is converted into embeddings
  
  Embeddings are stored in ChromaDB (per paper ID)
  
  User asks questions or requests summary 
  
  Relevant chunks are retrieved and sent to the LLM
  
  AI generates a context-aware response
  

🛠️ Tech Stack:

  📱 Frontend
  
  Flutter
  Dart
  HTTP package
  
  ⚙️ Backend
  
  FastAPI
  Python
  
  🤖 AI / ML
  
  LangChain
  Google Gemini API
  HuggingFace Embeddings (bge-small-en-v1.5)
  
  🗄️ Vector DB
  
  ChromaDB
  
  📄 PDF Processing
  
  PyMuPDF (fitz)
  
  
📁 Project Structure

  Arcana/
  │
  ├── Backend/
  │   ├── main.py
  │   ├── routes/
  │   │   ├── upload.py
  │   │   ├── chat.py
  │   │   ├── summary.py
  │   ├── rag/
  │       ├── extract_text.py
  │       ├── chunk_text.py
  │       ├── embeddings.py
  │       ├── vector_db.py
  │       ├── retriever.py
  │       ├── llm.py
  │
  ├── frontend/ (Flutter App)
  │   ├── lib/
  │       ├── screens/
  │       ├── widgets/
  │
  ├── storage/ (ignored in git)
  │   ├── papers/
  │   ├── chroma_db/
  │
  ├── .gitignore
  ├── README.md
  
⚙️ Setup Instructions

  1. Clone repository
  git clone https://github.com/your-username/Arcana.git
  cd Arcana


  2. Backend setup
    cd Backend
    python -m venv venv
    venv\Scripts\activate   # Windows
    pip install -r requirements.txt


  3. Run server:
    uvicorn Backend.main:app --reload

  
  4. Flutter setup
    cd frontend
    flutter pub get
    flutter run

🔐 Environment Variables

  Create a .env file in backend:
    GOOGLE_API_KEY=your_api_key_here
  
📌 API Endpoints

  📤 Upload PDF
  
    POST /upload
  💬 Chat with Paper
  
    POST /chat
  🧾 Summarize Paper
  
    POST /summarize
  
🧪 Example Use Case

  Upload a research paper (PDF)
  
  Ask:
    “What is the methodology?”
    “Explain the results”
    
  Get AI-powered answers based on the paper only
  
  Generate structured summary instantly

  
⚠️ Important Notes

.env and storage/ are ignored in Git
Each paper is stored using a unique UUID
ChromaDB is used per document for isolation
Designed for local + scalable deployment


🚀 Future Improvements

  Multi-user authentication system
  
  Cloud vector database integration
  
  Streaming AI responses
  
  Mobile PDF preview
  
  Voice-based Q&A
  
  Research paper comparison mode

  

Built by Malak
AI Engineer | Mobile Developer
