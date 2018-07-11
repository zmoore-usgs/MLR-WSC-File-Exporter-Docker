# MLR-WSC-File-Exporter-Docker
Docker configuration to deploy the MLR-WSC-File-Exporter service in a Docker container

[![Build Status](https://travis-ci.org/USGS-CIDA/MLR-WSC-File-Exporter-Docker.svg?branch=master)](https://travis-ci.org/USGS-CIDA/MLR-WSC-File-Exporter-Docker)
[![Coverage Status](https://coveralls.io/repos/github/USGS-CIDA/MLR-WSC-File-Exporter-Docker/badge.svg?branch=master)](https://coveralls.io/github/USGS-CIDA/MLR-WSC-File-Exporter-Docker?branch=master)

The two docker files provided pull the artifact from cida.usgs.gov/artifactory. The build type and version should be 
specfied as build-arg's when building the image. The argument build_type should be 'snapshots' or 'releases'. The 
artfact_version should be the version of the usgs-wma-mlr-wsc-file-exporter that you want to be used in the docker 
container. The optional build argument, 'listening_port' can be specified and defaults to 7010. 
This port will be exposed by the container. To build within the DOI network, use Dockerfile-DOI and place the DOI 
cert in '/rootcrt'. Below is an example of how to build.
```bash
docker build -t mlr_file_exporter -f Dockerfile-DOI .
```

To run, you can specify a bind mount on the host system where you want the exported files written (the src part of the bind). 
Below is an example:
```bash
docker run --publish 5000:7010 \
    --env auth_token_key_url=https://path.com/to/token_key\
    --env jwt_algorithm=HS256 \
    --env jwt_decode_audience=string_in_aud_claim_in_token \
    --env auth_cert_path=path_to_auth_cert or False (not recommended) if disabling SSL verification \
    --env authorized_roles='admin, developer' # Comma separate list of roles that will be allowed
    mlr_file_exporter
```