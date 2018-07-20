FROM cidasdpdasartip.cr.usgs.gov:8447/mlr-python-base-docker:latest

LABEL maintainer="gs-w_eto_eb_federal_employees@usgs.gov"

ENV USER=python
ENV HOME=/home/$USER
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
ENV CERT_IMPORT_DIRECTORY=$HOME/certificates

USER root
RUN pip3 install -q --no-cache-dir gunicorn==19.7.1 &&\
    pip3 install -q --no-cache-dir --extra-index-url https://cida.usgs.gov/artifactory/api/pypi/${repo_name}/simple -v ${artifact_id}==${artifact_version}
COPY entrypoint.sh $HOME/entrypoint.sh
COPY gunicorn_config.py $HOME/local/gunicorn_config.py
RUN chown $USER:$USER $HOME/entrypoint.sh $HOME/local/gunicorn_config.py
RUN ["chmod", "+x", "entrypoint.sh"]
USER $USER
RUN mkdir -p $HOME/certificates

VOLUME /export_results
ENTRYPOINT ["./entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -k ${protocol}://127.0.0.1:${listening_port}/version | grep -q "\"artifact\": \"${artifact_id}\"" || exit 1
