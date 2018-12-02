docker build -t vadymshevchenko/react-client -t vadymshevchenko/multi-client:$GIT_SHA ./client
docker build -t vadymshevchenko/react-server -t vadymshevchenko/multi-client:$GIT_SHA ./server
docker build -t vadymshevchenko/react-worker -t vadymshevchenko/multi-client:$GIT_SHA ./worker

# Take those images and push them to Docker Hub
docker push vadymshevchenko/react-client:latest
docker push vadymshevchenko/react-server:latest
docker push vadymshevchenko/react-worker:latest
docker push vadymshevchenko/react-client:$GIT_SHA 
docker push vadymshevchenko/react-server:$GIT_SHA 
docker push vadymshevchenko/react-worker:$GIT_SHA 

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=vadymshevchenko/react-client:$GIT_SHA
kubectl set image deployments/server-deployment server=vadymshevchenko/react-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=vadymshevchenko/react-worker:$GIT_SHA