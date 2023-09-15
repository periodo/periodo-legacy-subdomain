.PHONY: stage publish clean

stage: CLIENT_HOST = client.staging.perio.do
stage: DATA_HOST = data.staging.perio.do
stage: PERMALINK = https://data.staging.perio.do/

publish: CLIENT_HOST = client.perio.do
publish: DATA_HOST = data.perio.do
publish: PERMALINK = https://n2t.net/ark:/99152/p0

stage publish: clean nginx.conf
	fly deploy

clean:
	rm -f nginx.conf

nginx.conf: nginx.template.conf
	CLIENT_HOST=$(CLIENT_HOST) \
	DATA_HOST=$(DATA_HOST) \
	PERMALINK=$(PERMALINK) \
	envsubst '$$CLIENT_HOST $$DATA_HOST $$PERMALINK' < $< > $@
