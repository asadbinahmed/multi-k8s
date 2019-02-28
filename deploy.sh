docker build -t ahmedhaigi/multi-client:latest -t ahmedhaigi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahmedhaigi/multi-server:latest -t ahmedhaigi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahmedhaigi/multi-worker:latest -t ahmedhaigi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ahmedhaigi/multi-client:latest
docker push ahmedhaigi/multi-server:latest
docker push ahmedhaigi/multi-worker:latest

docker push ahmedhaigi/multi-client:$SHA
docker push ahmedhaigi/multi-server:$SHA
docker push ahmedhaigi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ahmedhaigi/multi-server:$SHA
kubectl set image deployments/client-deployment client=ahmedhaigi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ahmedhaigi/multi-worker:$SHA
