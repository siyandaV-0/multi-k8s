docker build -t siyandav0/multi-client:latest -t siyandav0/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t siyandav0/multi-server:latest -t siyandav0/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t siyandav0/multi-worker:latest -t siyandav0/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push siyandav0/multi-client:latest
docker push siyandav0/multi-server:latest
docker push siyandav0/multi-worker:latest

docker push siyandav0/multi-client:$SHA
docker push siyandav0/multi-server:$SHA
docker push siyandav0/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=siyandav0/multi-server:$SHA
kubectl set image deployments/client-deployment server=siyandav0/multi-client:$SHA
kubectl set image deployments/worker-deployment server=siyandav0/multi-worker:$SHA