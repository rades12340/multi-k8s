docker build -t rades12340/multi-client:latest -t rades12340/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rades12340/multi-server:latest -t rades12340/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rades12340/multi-worker:latest -t rades12340/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rades12340/multi-client:latest
docker push rades12340/multi-server:latest
docker push rades12340/multi-worker:latest
docker push rades12340/multi-client:$SHA
docker push rades12340/multi-server:$SHA
docker push rades12340/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rades12340/multi-server:$SHA
kubectl set image deployments/client-deployment client=rades12340/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rades12340/multi-worker:$SHA