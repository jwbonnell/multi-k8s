docker build -t jwbonnell/fib-react-client:latest -t jwbonnell:fib-react-client:$SHA -f ./client/Dockerfile ./client
docker build -t jwbonnell/fib-react-server:latest -t jwbonnell:fib-react-server:$SHA -f ./server/Dockerfile ./server
docker build -t jwbonnell/fib-react-worker:latest -t jwbonnell:fib-react-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jwbonnell/fib-react-client:latest
docker push jwbonnell/fib-react-server:latest
docker push jwbonnell/fib-react-worker:latest

docker push jwbonnell/fib-react-client:$SHA
docker push jwbonnell/fib-react-server:$SHA
docker push jwbonnell/fib-react-worker:$SHA


kubectl apply -f k8s
kubectl set image deployment/server-deployment server=jwbonnell/fib-react-server:$SHA
kubectl set image deployment/client-deployment client=jwbonnell/fib-react-client:$SHA
kubectl set image deployment/worker-deployment worker=jwbonnell/fib-react-worker:$SHA