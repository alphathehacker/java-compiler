# Base image with Ubuntu
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Python, pip, and OpenJDK (Java)
RUN apt-get update && apt-get install -y \
    python3.10 python3-pip openjdk-17-jdk \
    && apt-get clean

# Set environment variable for Java
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose port
EXPOSE 5000

# Run your app
CMD ["python3", "app.py"]
