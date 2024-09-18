FROM python:3.9-slim

RUN apt-get update && \
  apt-get install -y git bison flex g++ protobuf-compiler libprotobuf-dev \
  libnl-route-3-dev libnl-genl-3-dev pkg-config && \
  git clone --depth 1 https://github.com/google/nsjail.git && \
  cd nsjail && \
  make && \
  mv nsjail /bin && \
  cd .. && \
  rm -rf nsjail && \
  apt-get remove --purge -y git bison flex g++ protobuf-compiler libprotobuf-dev && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

EXPOSE 8080

CMD ["python", "app.py"]
