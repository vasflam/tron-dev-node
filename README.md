# Tron Development Node Docker

This repository provides a **Dockerfile** and a **Makefile** to build and run a Tron development node. The setup includes all mainnet proposals and a development wallet for testing.

## **Features**
- Tron FullNode version **GreatVoyage-v4.7.7**
- Runs in a **Docker container**
- Includes a **development wallet** with pre-configured proposals
- Supports **customizable environment variables**
- Allows **Docker volume** for persistent blockchain database storage

---

## **Getting Started**
### **1. Clone the Repository**
```sh
git clone https://github.com/your-repository/tron-node-docker.git
cd tron-node-docker
```

### **2. Build the Docker Image**
```sh
make build
```
This will:
1. Download `FullNode.jar` if not already present.
2. Extract database files from `database.tar.gz`.
3. Build the **Docker image** `tron-node:latest`.
4. Clean up extracted database files after the build.

### **3. Run the Tron Development Node**
```sh
make run
```
This runs the Tron development node in a detached container with the following ports exposed:
- **8081** → HTTP Full Node API
- **8082** → HTTP Solidity Node API

To verify if the container is running:
```sh
docker ps
```

### **4. Access the Development Wallet**
- **Wallet Address:** `TPL66VK2gCXNCD7EJg9pgJRfqcRazjhUZY`
- **Private Key:** `da146374a75310b9666e834ee4ad0866d6f4035967bfc76217c5a495fff9f0d0`

Use this wallet for testing transactions on the development node.

---

## **Environment Variables**
| Variable Name | Default Value |
|--------------|--------------|
| `HTTP_FULL_NODE_PORT` | `8081` |
| `HTTP_SOLIDITY_PORT` | `8082` |
| `RPC_PORT` | `50051` |
| `BLOCK_MAINTENANCE_INTERVAL` | `300000` |
| `BLOCK_PROPOSAL_EXPIRE_TIME` | `30000` |

### **Example: Passing Environment Variables to Docker**
```sh
docker run -d \
    -p 8081:8081 -p 8082:8082 -p 50051:50051 \
    -e HTTP_FULL_NODE_PORT=8081 \
    -e HTTP_SOLIDITY_PORT=8082 \
    -e RPC_PORT=50051 \
    -e BLOCK_MAINTENANCE_INTERVAL=300000 \
    -e BLOCK_PROPOSAL_EXPIRE_TIME=30000 \
    --name tron-node tron-node:latest
```

---

## **Persisting Blockchain Data**
To persist blockchain data, **create a Docker volume** and mount it to `/tron/output-directory/database`:

```sh
docker volume create tron-db

docker run -d \
    -p 8081:8081 -p 8082:8082 -p 50051:50051 \
    -v tron-db:/tron/output-directory/database \
    --name tron-node tron-node:latest
```
This ensures the database persists even if the container is stopped or removed.

### **Extracting Database Files to a Custom Volume**
If you want to extract the default database containing all applied proposals to a custom volume, use the following approach:

```sh
docker volume create tron-db
docker exec --rm -v tron-db:/mnt --entrypoint /bin/sh tron-node:latest -c "cp -r /tron/output-directory/database/ /mnt"
```
This will extract the default blockchain database into the created volume, making it available for persistent use when the container starts.

---

## **Stopping and Removing the Container**
To stop the running Tron node:
```sh
docker stop tron-node
```
To remove the container:
```sh
docker rm tron-node
```
To remove the built image:
```sh
docker rmi tron-node:latest
```

---

Happy building! 🚀


