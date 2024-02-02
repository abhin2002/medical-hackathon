# Build the data store base for the hospital

import os
from langchain.chains import RetrievalQA
from langchain.document_loaders import PyPDFLoader
from langchain.embeddings import OpenAIEmbeddings
from langchain.text_splitter import CharacterTextSplitter
from langchain_community.vectorstores import FAISS


import time

import os
from dotenv import load_dotenv

load_dotenv()

# Supress warnings
import warnings
warnings.filterwarnings("ignore")

print("Loading PDF...")
loader = PyPDFLoader("data/first aid.pdf")
documents = loader.load()

split_start_time = time.time()
# split the documents into chunks
print("Splitting documents...")
text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
texts = text_splitter.split_documents(documents)
print("Split into {} chunks".format(len(texts)))



# select which embeddings we want to use
embeddings = OpenAIEmbeddings()
print("Loading embeddings...")
# create the vectorestore to use as the index
db = FAISS.from_documents(texts, embeddings)
db.save_local("faiss_index")
print("Loading took {0}s".format(time.time()-split_start_time))