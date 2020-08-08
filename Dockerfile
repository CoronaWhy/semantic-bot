FROM ubuntu:19.04
MAINTAINER Vyacheslav Tykhonov
RUN apt-get update && apt-get install -y python3
#RUN apt-get install -y python3 pip3
COPY . /ontology-mapping-chatbot
RUN pip install pybind11==2.2.2
WORKDIR /ontology-mapping-chatbot
RUN pip install -r requirements.txt
#RUN apt-get update
RUN apt-get install npm
RUN npm install -g yarn
ENV WORKDIR=/ontology-mapping-chatbot
ENV DJANGO_SETTINGS_MODULE=chatbot_app.local_settings
ENV PYTHONPATH=$WORKDIR
ENV DATADIR=$WORKDIR/data_dumps
ENTRYPOINT ["python"]
CMD ["manage.py", "migrate"]
CMD ["manage.py", "collectstatic"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]
EXPOSE 8000
EXPOSE 8001
