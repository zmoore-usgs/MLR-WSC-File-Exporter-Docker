# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html). (Patch version X.Y.0 is implied if not specified.)

## [Unreleased]
### Added
- kmschoep@usgs.gov - Dockerfile
- kmschoep@usgs.gov - gunicorn_config.py
- kmschoep@usgs.gov - docker-compose.yml
- kmschoep@usgs.gov - docker-compose.env
- kmschoep@usgs.gov - wildcard-dev.crt
- kmschoep@usgs.gov - wildcard-dev.csr
- kmschoep@usgs.gov - wildcard-dev.key
- kmschoep@usgs.gov - nginx.conf
- kmschoep@usgs.gov - import_certs.sh
- isuftin@usgs.gov - secrets.env and config.env, split out from docker-compose.env
- isuftin@usgs.gov - wildcard demo certificates into config/certificates directory
- isuftin@usgs.gov - certificates into docker-compose mounting  
- isuftin@usgs.gov - python user env vars into Dockerfile
- isuftin@usgs.gov - import-certificates script run at entrypoint

### Fixed
- isuftin@usgs.gov - Healthcheck now works as expected after escaping quotes

### Changed
- isuftin@usgs.gov - cleaned up Dockerfile order of operations for importing certificates
- isuftin@usgs.gov - pip installation is now less verbose
- isuftin@usgs.gov - Travis test for running container

### Removed
- isuftin@usgs.gov - import_certs.sh - Now run from base container
