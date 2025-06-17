# Use a lightweight Python image
FROM python:3.10-slim

# Install Java (OpenJDK 17)
RUN apt-get update && apt-get install -y openjdk-17-jdk && apt-get clean

# Set Java environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Set the working directory
WORKDIR /app

# Copy all files into the container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the default Flask port
EXPOSE 5000

# Start your Flask app
CMD ["python", "app.py"]
