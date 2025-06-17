# 🔧 Java Compiler Web App

A web-based Java compiler and executor built using **Flask**, allowing users to write, compile, and run Java code directly from the browser. Designed for simplicity and ease of use, inspired by OneCompiler.

> 🚀 Live Demo: [Visit Web App](https://java-compiler-3dol.onrender.com)

---

## 📸 Preview

![Web App Screenshot](preview.png) <!-- Replace with actual image if available -->

---

## 🧰 Tech Stack

- **Frontend**: HTML, Tailwind CSS, CodeMirror
- **Backend**: Python (Flask)
- **Compiler**: javac (Java Development Kit required)
- **Deployment**: Render

---

## ✨ Features

- Multiple file tabs (Add, Rename, Delete)
- Real-time Java compilation with `javac`
- Execution via `subprocess.run()`
- Displays compiler errors and runtime output
- Auto scroll to output
- Clean, professional UI using Tailwind CSS
- CodeMirror editor with syntax highlighting

---

## 🚀 Deployment Instructions (Local)

### ⚙️ Prerequisites

- Python 3.8+
- JDK (Java Development Kit) installed and `javac` added to system path
- pip

### 🛠️ Setup

```bash
git clone https://github.com/alphathehacker/java-compiler.git
cd java-compiler

# (Optional) Create virtual environment
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows

# Install dependencies
pip install -r requirements.txt

# Run the app
python app.py
