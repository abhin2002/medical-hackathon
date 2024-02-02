from flask import Flask, request, jsonify
from rag import load_rag_pipeline, answer_question

qa = load_rag_pipeline()

app = Flask(__name__)
@app.route('/', methods=['GET'])
def index():
  response_data = {'check': "port running..."}
  return jsonify(response_data), 200

@app.route('/devRAG', methods=['POST'])
def devRAG():
    try:
        data = request.get_json()
        input_text = data.get('query', '')
        ans = answer_question(input_text,qa)

        response_data = {'output': ans['result']}

        return jsonify(response_data), 200

    except Exception as e:
        
        error_message = f"Error: {str(e)}"
        return jsonify({'error': error_message}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8443, debug=True)
