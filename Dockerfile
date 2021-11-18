ARG IMAGE=containers.intersystems.com/intersystems/irishealth:2021.1.0.215.0
ARG IMAGE=containers.intersystems.com/intersystems/iris:2021.1.0.215.0
FROM $IMAGE 
COPY keys/iris.key /usr/irissys/mgr/iris.key
COPY ./src/scripts/iam.script /tmp/iam.script

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iam.script \
	&& iris stop IRIS quietly 

ARG IRIS_PASSWORD
RUN echo "${IRIS_PASSWORD}" > /tmp/password.txt && /usr/irissys/dev/Container/changePassword.sh /tmp/password.txt

USER root   

RUN mkdir /src /data /databases && chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /src /data /databases

USER ${ISC_PACKAGE_MGRUSER}
