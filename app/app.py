from flask import Flask, jsonify, send_from_directory

app = Flask(__name__)

# API Endpoint
@app.route('/api/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy"})

# Serve Frontend
@app.route('/')
def serve_frontend():
    return send_from_directory('static', 'index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
