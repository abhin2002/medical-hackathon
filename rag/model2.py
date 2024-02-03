from transformers import AutoModelForCausalLM, CodeGenTokenizerFast as Tokenizer
from PIL import Image

model_id = "vikhyatk/moondream1"
model = AutoModelForCausalLM.from_pretrained(model_id, trust_remote_code=True)
tokenizer = Tokenizer.from_pretrained(model_id)

image = Image.open(r'C:\Users\itsab\Desktop\hackthon\huggingFace\omal.jpeg')
enc_image = model.encode_image(image)
print(model.answer_question(enc_image, "Give detail on this accident situtaion", tokenizer))
