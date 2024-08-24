FROM flink:latest

# Install Python 3.10 and dependencies
RUN apt-get update -y && \
    apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libffi-dev \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a symlink for 'python' to point to 'python3.10'
RUN ln -s /usr/bin/python3.10 /usr/bin/python

# Set environment variables for Python
ENV PYTHON_HOME=/usr
ENV PATH="$PYTHON_HOME/bin:$PATH"


# Optionally, set the default pip to use python3.10
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Verify Python and pip versions
RUN python --version
RUN pip --version

# Install PyFlink
COPY apache-flink*.tar.gz /
COPY apache-flink-libraries-1.20.0.tar.gz /
RUN pip install /apache-flink-libraries-1.20.0.tar.gz && \
    pip install /apache-flink*.tar.gz
