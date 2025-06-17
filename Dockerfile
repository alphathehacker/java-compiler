# Base image with Ubuntu
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Java and Python
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    python3 \
    python3-pip \
    && apt-get clean

# Set JAVA path
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt

# Expose port (adjust if needed)
EXPOSE 5000

# Run Flask app
CMD ["python3", "app.py"]
