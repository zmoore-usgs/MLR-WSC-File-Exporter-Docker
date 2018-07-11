FROM alpine:3.6

ENV repo_name=usgs-python-centralized
ENV artifact_id=usgs-wma-mlr-wsc-file-exporter
ENV artifact_version=0.6.0.dev0

ENV listening_port=7010
ENV protocol=https

COPY gunicorn_config.py /local/gunicorn_config.py
RUN pip3 install  gunicorn==19.7.1 &&\
    pip3 install  --extra-index-url https://cida.usgs.gov/artifactory/api/pypi/${repo_name}/simple -v ${artifact_id}==${artifact_version}

ENV bind_port ${listening_port}
ENV log_level INFO
VOLUME /export_results
EXPOSE ${bind_port}
CMD ["/usr/bin/gunicorn", "--reload",  "app", "--config", "file:/local/gunicorn_config.py"]

ENV hc_uri ${protocol}://127.0.0.1:${bind_port}/version
HEALTHCHECK CMD curl -k ${hc_uri} | grep -q '"artifact": "usgs-wma-mlr-wsc-file-exporter"' || exit 1