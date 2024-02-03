import os
from langchain.chains import RetrievalQA
from langchain.document_loaders import PyPDFLoader
from langchain.embeddings import OpenAIEmbeddings
from langchain.llms import OpenAI
from langchain.text_splitter import CharacterTextSplitter
from langchain_community.vectorstores import FAISS

import time

import os
from dotenv import load_dotenv

load_dotenv()

# Supress warnings
import warnings
warnings.filterwarnings("ignore")

def load_rag_pipeline(name = "faiss_index"):
    # Load the index
    db = FAISS.load_local(name, OpenAIEmbeddings())
    # Expose this index in a retriever interface
    retriever = db.as_retriever()
    # Create a chain to answer questions
    return RetrievalQA.from_chain_type(
        llm=OpenAI(),
        chain_type="map_reduce",
        retriever=retriever,
        return_source_documents=True,
        verbose=True,
    )


def answer_question(question,qa):
    context = "You are a helpful doctor that would provide patients with first aid information. Give them detailed and simple instructions. The input by the patient given seperated by hyphens ---{0}---"
    answer = qa(context.format(question))
    return answer

def report_to_doctor(answer):
    from openai import OpenAI

    client = OpenAI()

    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are a helpful assistant and you are required to send doctors some useful info about the patients before they arrive. Make the patient summary short and crisp"},
            {"role": "user", "content": "The details are are as follows {0}".format(answer)},
        ]
    )
    return response

if __name__ == "__main__":
    print("Building RAG pipeline...")
    start = time.time()
    # Load the RAG pipeline
    qa = load_rag_pipeline()
    print("Building took {0}s".format(time.time()-start))
    print("Done building RAG pipeline")
    print("Answering question...")
    start = time.time()
    # Answer a question
    ans = answer_question("He has a severe head injury",qa)

    print(ans['result'])

    doc_res = report_to_doctor(ans['result'])

    print(doc_res.choices[0].message.content)
    print("Answering took {0}s".format(time.time()-start))
    print("Done answering question")

        

