PROJECT = prometheus_rabbitmq_exporter

dep_prometheus = hex 3.5.1
dep_prometheus_process_collector = hex 1.3.1
dep_prometheus_httpd = hex 2.1.8
dep_accept = hex 0.3.3
dep_prometheus_cowboy = hex 0.1.4

DEPS = rabbit_common rabbit rabbitmq_management prometheus prometheus_httpd accept \
	prometheus_process_collector prometheus_cowboy

DEP_EARLY_PLUGINS = rabbit_common/mk/rabbitmq-early-plugin.mk
DEP_PLUGINS = rabbit_common/mk/rabbitmq-plugin.mk

# FIXME: Use erlang.mk patched for RabbitMQ, while waiting for PRs to be
# reviewed and merged.

ERLANG_MK_REPO = https://github.com/rabbitmq/erlang.mk.git
ERLANG_MK_COMMIT = rabbitmq-tmp

include rabbitmq-components.mk
include erlang.mk

.PHONY: docker_build docker_push docker_latest docker_pure docker_alpine

docker_build:
	docker build -t deadtrickster/rabbitmq_prometheus\:3.7.8 .
	docker build -t deadtrickster/rabbitmq_prometheus\:latest .
	docker build -t deadtrickster/rabbitmq_prometheus\:3.7.8-pure -f Dockerfile.pure  .
	docker build -t deadtrickster/rabbitmq_prometheus\:latest-pure -f Dockerfile.pure  .
	docker build -t deadtrickster/rabbitmq_prometheus\:3.7.8-alpine -f Dockerfile.alpine  .
	docker build -t deadtrickster/rabbitmq_prometheus\:latest-alpine -f Dockerfile.alpine  .

docker_push:
	docker push deadtrickster/rabbitmq_prometheus\:3.7.8
	docker push deadtrickster/rabbitmq_prometheus\:latest
	docker push deadtrickster/rabbitmq_prometheus\:3.7.8-pure
	docker push deadtrickster/rabbitmq_prometheus\:latest-pure
	docker push deadtrickster/rabbitmq_prometheus\:3.7.8-alpine
	docker push deadtrickster/rabbitmq_prometheus\:latest-alpine

docker_latest:
	-docker run -p15672\:15672 deadtrickster/rabbitmq_prometheus\:latest

docker_pure:
	-docker run -p15672\:15672 deadtrickster/rabbitmq_prometheus\:latest-pure

docker_alpine:
	-docker run -p15672\:15672 deadtrickster/rabbitmq_prometheus\:latest-alpine
