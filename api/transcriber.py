from flask import Flask, request, jsonify
# from googpeech
import os
from dotenv import load_dotenv


from directTranscriber import audioTanslate 

app = Flask(__name__)
load_dotenv()
@app.route('/', methods=['GET'])
def index():
  response_data = {'check': "port running..."}
  return jsonify(response_data), 200


@app.route('/transcribe', methods=['POST'])
def transcribe():
    if 'audio' not in request.files:
        return jsonify({'error': 'No audio file provided'}), 400

    audio_file = request.files['audio']
    audio_content = audio_file.read()

    if not audio_content:
        return jsonify({'error': 'Empty audio file'}), 400

    try:
        transcribed_text = audioTanslate(audio_content)
        return jsonify({'transcription': transcribed_text})

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=8443)
