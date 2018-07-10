FROM alpine:3.6

ENV repo_name=usgs-python-centralized
ENV artifact_id=usgs-wma-mlr-wsc-file-exporter
ENV artifact_version=0.6.0.dev0

ENV listening_port=7010
ENV protocol=https
RUN apk update && apk upgrade && mkdir /local
RUN apk add --update \
  python3 \
  python3-dev \
  build-base \
  ca-certificates \
  libffi-dev \
  openssl-dev \
  openssl \
  curl
COPY gunicorn_config.py /local/gunicorn_config.py
RUN export PIP_CERT="/etc/ssl/certs/ca-certificates.crt" && \
    pip3 install --upgrade pip && \
    pip3 install  gunicorn==19.7.1 &&\
    pip3 install  --extra-index-url https://cida.usgs.gov/artifactory/api/pypi/${repo_name}/simple -v ${artifact_id}==${artifact_version}
ENV bind_ip 0.0.0.0
ENV bind_port ${listening_port}
ENV log_level INFO
VOLUME /export_results
EXPOSE ${bind_port}
CMD ["/usr/bin/gunicorn", "--reload",  "app", "--config", "file:/local/gunicorn_config.py"]

ENV hc_uri ${protocol}://127.0.0.1:${bind_port}/version
HEALTHCHECK CMD curl -k ${hc_uri} | grep -q '"artifact": "usgs-wma-mlr-wsc-file-exporter"' || exit 1