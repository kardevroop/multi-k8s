docker build -t devroop/multi-client:latest -t devroop/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t devroop/multi-server:latest -t devroop/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t devroop/multi-worker:latest -t devroop/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push devroop/multi-client:latest
docker push devroop/multi-server:latest
docker push devroop/multi-worker:latest
docker push devroop/multi-client:$SHA
docker push devroop/multi-server:$SHA
docker push devroop/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=devroop/multi-server:$SHA
kubectl set image deployments/client-deployment client=devroop/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=devroop/multi-worker:$SHA