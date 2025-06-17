from flask import Flask, render_template, request, jsonify
import os
import subprocess

app = Flask(__name__)
SAVE_FOLDER = "saved_files"
os.makedirs(SAVE_FOLDER, exist_ok=True)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/save", methods=["POST"])
def save_files():
    data = request.get_json()
    files = data.get("files", {})
    for filename, content in files.items():
        path = os.path.join(SAVE_FOLDER, filename)
        with open(path, "w") as f:
            f.write(content)
    return "Files saved successfully!"

@app.route("/files")
def list_files():
    files = [f for f in os.listdir(SAVE_FOLDER) if f.endswith(".java")]
    return jsonify(files)

@app.route("/open", methods=["POST"])
def open_file():
    data = request.get_json()
    filename = data.get("filename")
    path = os.path.join(SAVE_FOLDER, filename)
    if not os.path.exists(path):
        return jsonify({"error": "File not found"}), 404
    with open(path, "r") as f:
        content = f.read()
    return jsonify({"filename": filename, "content": content})

@app.route("/compile", methods=["POST"])
def compile_code():
    data = request.get_json()
    files = data.get("files", {})
    stdin = data.get("stdin", "")
    main_file = ""

    compile_paths = []
    for filename, code in files.items():
        filepath = os.path.join(SAVE_FOLDER, filename)
        with open(filepath, "w") as f:
            f.write(code)
        compile_paths.append(filepath)
        if "public class" in code:
            main_file = filename.replace(".java", "")

    compile_cmd = ["javac"] + compile_paths
    try:
        subprocess.run(compile_cmd, check=True, capture_output=True, text=True)
    except subprocess.CalledProcessError as e:
        return jsonify({"output": e.stderr})

    if not main_file:
        return jsonify({"output": "No public class found to execute."})

    run_cmd = ["java", "-cp", SAVE_FOLDER, main_file]
    try:
        result = subprocess.run(run_cmd, input=stdin, capture_output=True, text=True, timeout=10)
        return jsonify({"output": result.stdout + result.stderr})
    except subprocess.TimeoutExpired:
        return jsonify({"output": "Execution timed out."})

if __name__ == "__main__":
    app.run(debug=True)
