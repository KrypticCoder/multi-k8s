docker build -t xdimitarx/multi-client:latest -t xdimitarx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xdimitarx/multi-server:latest -t xdimitarx/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t xdimitarx/multi-worker:latest -t xdimitarx/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push xdimitarx/multi-client:latest
docker push xdimitarx/multi-server:latest
docker push xdimitarx/multi-worker:latest
docker push xdimitarx/multi-client:$SHA
docker push xdimitarx/multi-server:$SHA
docker push xdimitarx/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=xdimitarx/multi-client:$SHA
kubectl set image deployments/server-deployment server=xdimitarx/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=xdimitarx/multi-worker:$SHA