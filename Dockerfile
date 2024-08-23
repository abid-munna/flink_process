# Use a base image with a suitable environment
FROM flink:latest

# Install Python 3.10 and dependencies
RUN apt-get update -y && \
    apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libffi-dev \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install pip for Python 3.10
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3.10 get-pip.py && \
    rm get-pip.py

# Install PyFlink
COPY apache-flink*.tar.gz /
COPY apache-flink-libraries-1.20.0.tar.gz /
RUN pip install /apache-flink-libraries-1.20.0.tar.gz && \
    pip install /apache-flink*.tar.gz

# # Clean up
# RUN rm /apache-flink*.tar.gz /apache-flink-libraries-1.20.0.tar.gz

# # Set the default Python version to 3.10
# RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# # Optionally, set the default pip to use python3.10
# RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3.10 1

# Set the working directory (if needed)
COPY src /

# Optional: Specify the entrypoint or command (if needed)
# ENTRYPOINT [ "python3.10" ]
# CMD [ "your-script.py" ]

