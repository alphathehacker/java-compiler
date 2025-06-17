# Use Ubuntu with Python
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Java + Python
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    python3 python3-pip \
    && apt-get clean

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Set work dir
WORKDIR /app

# Copy files
COPY . .

# Install Python packages
RUN pip3 install -r requirements.txt

# Expose port
EXPOSE 5000

# Start app
CMD ["python3", "app.py"]
