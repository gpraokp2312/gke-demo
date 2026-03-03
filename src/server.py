from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello_world():
    # Retrieve environment variable or use default
    message = os.environ.get("APP_MESSAGE", "***  Hello from GKE Demo, NTT Niveus! Welcome***")
    return f"<p>{message}</p>"

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=8080)

