docker build -t chrisocal/multi-client:latest -t chrisocal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chrisocal/multi-server:latest -t chrisocal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chrisocal/multi-worker:latest -t chrisocal/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chrisocal/multi-client:latest
docker push chrisocal/multi-server:latest
docker push chrisocal/multi-worker:latest
docker push chrisocal/multi-client:$SHA
docker push chrisocal/multi-server:$SHA
docker push chrisocal/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chrisocal/multi-server:$SHA
kubectl set image deployments/client-deployment client=chrisocal/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=chrisocal/multi-worker:$SHA
