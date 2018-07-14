FROM ubuntu:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    git \
    python \
    python-pip \
    python-setuptools

RUN pip install tf-nightly


# Checkout  at HEAD
RUN git clone https://github.com/preconceived-notions/ashamed-nostradamus /ashamed-nostradamus

WORKDIR /ashamed-nostradamus

RUN pip install -r requirements.txt

CMD ["run.py"]
