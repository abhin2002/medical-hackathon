from fastapi import FastAPI, HTTPException

from rag import load_rag_pipeline,answer_question

app = FastAPI()

# Paste the existing code here

# Load the RAG pipeline
qa_pipeline = load_rag_pipeline()

@app.post("/answer")
async def get_answer(text: str):
    try:
        # Call the answer_question function with the provided text
        result = answer_question(text, qa_pipeline)
        return {"answer": result}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
