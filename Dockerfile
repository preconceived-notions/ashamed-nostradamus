FROM tensorflow/tensorflow:1.7.0-gpu

RUN mkdir -p ashamed-nostradamus

WORKDIR /ashamed-nostradamus

ADD requirements.txt requirements.txt

RUN pip install -r requirements.txt

CMD ["run.py"]
