# Use Ubuntu base
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install OpenJDK 17 and Python 3
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk python3 python3-pip && \
    apt-get clean

# Set environment variables for Java
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Set workdir
WORKDIR /app

# Copy app files
COPY . .

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Expose the port Flask runs on
EXPOSE 5000

# Run Flask app
CMD ["python3", "app.py"]
