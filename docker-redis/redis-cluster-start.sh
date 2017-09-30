docker run -tid -p 7000 7001 70002 --name redis-cluster-test  .. yujieshui/redis-cluster
docker exec redis-cluster-test redis-ckuster-start.sh 