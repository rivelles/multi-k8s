docker build -t lucasrivelles/multi-client:latest -t lucasrivelles/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lucasrivelles/multi-server:latest -t lucasrivelles/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lucasrivelles/multi-worker:latest -t lucasrivelles/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lucasrivelles/multi-client:latest
docker push lucasrivelles/multi-server:latest
docker push lucasrivelles/multi-worker:latest

docker push lucasrivelles/multi-client:$SHA
docker push lucasrivelles/multi-server:$SHA
docker push lucasrivelles/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lucasrivelles/multi-client:$SHA
kubectl set image deployments/server-deployment server=lucasrivelles/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lucasrivelles/multi-worker:$SHA