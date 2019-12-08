FROM python:3.8-alpine

RUN set -e; \
	apk add --no-cache --virtual .build-deps \
		gcc \
		libc-dev \
		linux-headers \
	;

RUN addgroup -S uwsgi && adduser -S -g uwsgi uwsgi
RUN pip install --upgrade pip && pip install Flask==0.10.1 uWSGI requests==2.5.1 redis==2.10.3
WORKDIR /app
COPY app /app
COPY cmd.sh /
RUN chmod +x /cmd.sh

EXPOSE 9090 9191
USER uwsgi

CMD ["sh", "/cmd.sh"]