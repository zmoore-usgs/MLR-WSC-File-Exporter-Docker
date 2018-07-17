FROM cidasdpdasartip.cr.usgs.gov:8447/mlr-python-base-docker:latest

ENV repo_name=usgs-python-centralized
ENV artifact_id=usgs-wma-mlr-wsc-file-exporter
ENV artifact_version=0.6.0.dev0
ENV listening_port=7010
ENV protocol=https
ENV log_level INFO
ENV requireSsl=true
ENV serverPort=443
ENV serverContextPath=/
ENV S3_BUCKET=default-location
ENV AWS_REGION=default-region
ENV TIERNAME=development
ENV authorized_roles=test_default
ENV CERT_IMPORT_DIRECTORY=/

COPY import_certs.sh import_certs.sh
COPY entrypoint.sh entrypoint.sh

RUN ["chmod", "+x", "import_certs.sh", "entrypoint.sh"] && \
	["./import_certs.sh"]

COPY gunicorn_config.py /local/gunicorn_config.py
RUN pip3 install  gunicorn==19.7.1 &&\
    pip3 install  --extra-index-url https://cida.usgs.gov/artifactory/api/pypi/${repo_name}/simple -v ${artifact_id}==${artifact_version}


VOLUME /export_results

ENTRYPOINT ["./entrypoint.sh"]

ENV hc_uri ${protocol}://127.0.0.1:${listening_port}/version
HEALTHCHECK CMD curl -k ${hc_uri} | grep -q '"artifact": "usgs-wma-mlr-wsc-file-exporter"' || exit 1