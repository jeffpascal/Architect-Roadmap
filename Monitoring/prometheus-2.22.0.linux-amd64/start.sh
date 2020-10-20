docker build --rm -t my-prometheus .
docker run --name prometheus --rm -d -p 9090:9090 my-prometheus
