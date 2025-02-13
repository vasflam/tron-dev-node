FULL_NODE_VERSION="GreatVoyage-v4.7.7"
download:
	curl -L -o ./files/FullNode.jar https://github.com/tronprotocol/java-tron/releases/download/${FULL_NODE_VERSION}/FullNode.jar
build:
	if [ ! -f "./files/FullNode.jar" ]; then make download; fi; \
	cd ./files; tar -zxvf ./database.tar.gz ; cd .. ; \
	docker build --platform linux/amd64 -t tron-node:latest . ;\
	rm -rf ./files/database
run:
	docker run -d -p 8081:8081 -p 8082:8082 -p 50051:50051 --name tron-node tron-node:latest
