import os
import socket
from flask import Flask
import pymysql

app = Flask(__name__)

def get_connection():
    return pymysql.connect(
        host=os.getenv('DB_HOST', '10.10.20.152'),  # Fallback to private IP if env var is unset
        user=os.getenv('DB_USER', 'db_user'),
        password=os.getenv('DB_PASSWORD', 'Passw0rd'),
        database=os.getenv('DB_NAME', 'employee_db'),
        cursorclass=pymysql.cursors.DictCursor,
        connect_timeout=5
    )

@app.route("/")
def main():
    hostname = socket.gethostname()
    return f"Welcome! Response from {hostname}"

@app.route("/how are you")
def hello():
    hostname = socket.gethostname()
    return f"I am good, how about you? (served by {hostname})"

@app.route("/employees")
def employees():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM employees")
        rows = cursor.fetchall()
        conn.close()

        hostname = socket.gethostname()
        return {
            "served_by": hostname,
            "data": rows
        }

    except Exception as e:
        return {"error": str(e)}, 500