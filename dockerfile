FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install python3.6
RUN apt-get update
RUN apt-get install python3-virtualenv -y
#RUN virtualenv -p /usr/bin/python3.6 venv
RUN apt install python3-pip -y
WORKDIR /app
COPY . .
RUN pip3 install -r requirements.txt
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate
CMD python3 manage.py runserver 0.0.0.0:8000
