docker build -t siyandav0/multi-client:latest -t siyandav0/multi-client:$CIRCLE_SHA1 -f ./client/Dockerfile ./client
docker build -t siyandav0/multi-server:latest -t siyandav0/multi-server:$CIRCLE_SHA1 -f ./server/Dockerfile ./server
docker build -t siyandav0/multi-worker:latest -t siyandav0/multi-worker:$CIRCLE_SHA1 -f ./worker/Dockerfile ./worker

docker push siyandav0/multi-client:latest
docker push siyandav0/multi-server:latest
docker push siyandav0/multi-worker:latest

docker push siyandav0/multi-client:$CIRCLE_SHA1
docker push siyandav0/multi-server:$CIRCLE_SHA1
docker push siyandav0/multi-worker:$CIRCLE_SHA1

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=siyandav0/multi-server:$CIRCLE_SHA1
kubectl set image deployments/client-deployment client=siyandav0/multi-client:$CIRCLE_SHA1
kubectl set image deployments/worker-deployment worker=siyandav0/multi-worker:$CIRCLE_SHA1