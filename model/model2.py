from transformers import AutoModelForCausalLM, CodeGenTokenizerFast as Tokenizer
from PIL import Image

from ..rag.rag import load_rag_pipeline, answer_question

model_id = "vikhyatk/moondream1"
model = AutoModelForCausalLM.from_pretrained(model_id, trust_remote_code=True)
tokenizer = Tokenizer.from_pretrained(model_id)

image = Image.open(r'C:\Users\itsab\Desktop\hackthon\huggingFace\dead.jpg')
enc_image = model.encode_image(image)

prompt = "You are an emergency assistant and you have to give detail on this accident situtaion in the image for a first aid."
response = model.answer_question(enc_image,prompt, tokenizer)

print(response)

# Get the recommended first aid
qa = load_rag_pipeline()
ans = answer_question(response,qa)

