FROM alpine:edge
MAINTAINER George Kutsurua <g.kutsurua@gmail.com>

RUN apk add --no-cache libxml2 libxml2-dev libxslt libxslt-dev zlib zlib-dev libffi-dev libssl1.0 \
                       python python-dev openssl-dev openssl ca-certificates gcc musl-dev linux-headers &&\
    wget -O - https://bootstrap.pypa.io/get-pip.py | python

RUN pip install scrapy scrapyd scrapy-sentry scrapy-sqlitem scrapy-splitvariants \
                scrapy-streamitem scrapy-statsd scrapy-redis scrapy-rabbitmq scrapy-querycleaner \
                scrapy-proxy-rotator scrapy-proxies scrapy-pagestorage scrapy-notifications \
                scrapy-rabbitmq-link scrapy-jsonrpc scrapy-itemagic scrapy-inline-requests \
                scrapy-fake-useragent scrapy-eagle scrapy-beautifulsoup \
                scrapy-elasticsearch-bulk-item-exporter requests ScrapyElasticSearch

RUN apk del libxml2-dev libxslt-dev zlib-dev libffi-dev python-dev \
            openssl-dev gcc musl-dev linux-headers && \
	rm -rf /var/cache/apk/*

COPY scrapyd.conf /etc/scrapyd/scrapyd.conf

VOLUME ["/data"]

ENTRYPOINT ["scrapyd"]

EXPOSE 8000
