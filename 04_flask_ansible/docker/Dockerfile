FROM python
RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
RUN pip install Flask uWSGI emoji
WORKDIR /flask_app
COPY flask_app /flask_app
EXPOSE 8080
USER uwsgi

CMD [ "uwsgi", "--socket", "0.0.0.0:8080", \
               "--uid", "uwsgi", \
               "--protocol", "http", \
               "--wsgi", "app:app" ]
