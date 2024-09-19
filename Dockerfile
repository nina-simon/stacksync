FROM python:3.9-slim

# Install necessary packages one by one
RUN apt-get update && \
  apt-get install -y \
  git \
  bison \
  flex \
  g++ \
  protobuf-compiler libprotobuf-dev \
  libnl-route-3-dev libnl-genl-3-dev \
  pkg-config \
  make

# Clone and build nsjail
RUN git clone --depth 1 https://github.com/google/nsjail.git && \
  cd nsjail && \
  make && \
  mv nsjail /usr/local/bin

# Cleanup unnecessary packages, keep necessary runtime libraries
RUN apt-get remove -y git bison flex g++ make pkg-config && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf nsjail

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

EXPOSE 8080

CMD ["python", "script.py"]
