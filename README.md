# Configure ReactJS with K8s ingress controllers

- This repo contains application that can be containerized and used for kubernetes environment
- This application accepts a environment variable <b>REACT_APP_BG_COLOR</b>
- You can provide input color codes/names, which will be reflected on the browser background during the docker build stage mentioned on dockerfile
- This application exposed to port 3000

## To create docker container
``` bash
docker build -f Dockerfile -t ashokjjk/colors:<color-name> .
```
### Dockerize
- Once we have the image, we can run multiple containers
- For demo purpose some tags are already created and readliy made available on docker hub
- Check that <a href="https://hub.docker.com/r/ashokjjk/colors/tags?page=1&ordering=last_updated">here</a>

``` bash
docker run -p 8080:3000 --rm -d --name red ashokjjk/colors:red
docker run -p 8081:3000 --rm -d --name orange ashokjjk/colors:orange
docker run -p 8082:3000 --rm -d --name green ashokjjk/colors:green
```

### Kubernetes ready
- This respository also contains k8s manifest
- This allows you to run the containers and configure ingress path
- Expose the application to outside world through ingress controller
- Here we use two types of ingress controller
  - Nginx ingress
  - Traefik
- Helm version 3 chart for ingress contoller can be used by the below commands
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx
```
- After successful installation loadbalancer service will be provisoned on cloud providers with static IP
- Now lets's deploy <b>manifest.yaml</b> using the below command on k8s cluster
``` bash
kubectl apply -f k8s-manifest.yaml
```

- Once all the pods are deployed, check out the loadbalancer external ip using
```
kubectl get svc -n default ingress-ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
```
- Once we have the external IP we can use it on the browser along with the exposed paths
  - /red
  - /green
  - /orange
- Check the sample result <a href="https://github.com/ashokjjk/react-kubernetes-ingress/blob/master/sample-shot-green.PNG">here</a>

