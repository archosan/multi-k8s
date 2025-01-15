docker build -t exodiums/multi-client:latest -t exodiums/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t exodiums/multi-server:latest -t exodiums/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t exodiums/multi-worker:latest -t exodiums/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push exodiums/multi-client:latest
docker push exodiums/multi-server:latest
docker push exodiums/multi-worker:latest

docker push exodiums/multi-client:$SHA
docker push exodiums/multi-server:$SHA
docker push exodiums/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=exodiums/multi-server:$SHA
kubectl set image deployments/client-deployment client=exodiums/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=exodiums/multi-worker:$SHA


