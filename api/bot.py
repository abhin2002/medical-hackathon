
from flask import Flask
from flask import jsonify
from flask import request
import requests
from flask_sslify import SSLify
from dotenv import load_dotenv
import os

app = Flask(__name__) 
sslify=SSLify(app)    

load_dotenv()

token = os.getenv("TELEGRAM_BOT_TOKEN")
FORWARD_API_URL = "https://3f5983c2-175c-44cf-8f1d-d987a1c8d91b-00-254vq5qtc47zr.pike.replit.dev/devRAG"

ongoing_tasks = {}    

def send_msg(chat_id, text):
  url = f"https://api.telegram.org/bot{token}/sendMessage"
  payload = {'chat_id': chat_id, 'text': text}
  requests.post(url, json=payload) 
  
@app.route('/', methods=['GET'])
def index():
  response_data = {'check': "port running..."}
  return jsonify(response_data), 200
  
@app.route('/', methods=['POST'])        
def process():
  global ongoing_tasks                         
  msg = request.get_json()             
  text = msg['message']['text']
  chat_id = msg['message']['chat']['id']
  try:
      print(text) 
      response = requests.post(FORWARD_API_URL,json={'query': text})

      result = response.json().get('output')
      print(result)
      send_msg(chat_id, result)

  except requests.exceptions.RequestException as e:
      error_message = f"Error forwarding message to API{str(e)}"
      send_msg(chat_id, error_message)

  return jsonify({'status': 'ok'})


if __name__ == '__main__':
   app.run(host='0.0.0.0',port=8443)