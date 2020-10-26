docker run -d  -p 25565:255565   --name myserver  itzg/minecraft-server

docker run -d -p 6379:6379 --name redis1 redis

docker logs  redis1
docker images 

docker ps ls 

docker exec -it redis1 sh 

## now we are in inside container(redis1) shell
ls  -al

redis-cli

Ping 

Set AzureTechDay Sunday
 get AzureTechDay  
 incr counter 
 incr counter 
get counter
exit 
#### exit from redi-cli
exit

## exit  from container redis1

##-----------------------------
docker run -it --rm --link redis1:redis --name client1 redis sh

## inside the containers

redis-cli -h redis

 get AzureTechDay 
 get counter 

exit 

###########


docker ps


docker stop redis1 

docker ps 

docker ps -a

docker rm redis1

dokcer image  rm  redis



##Docker container is defined to run application and not store data . If dispose container. Data in Container will be lost .
##How do we secure our data
 ##Storing Data in container
  ## Container are disposable 
	## Keep data in docker volumes
	##Mount a volume


docker run -d  -p  5432:5432 -v postgres-data:/var/lib/postgresql/data     --name postgres1 postgres   
docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres

docker exec -it postgres1 sh

createdb -U postgres mydb
psql -U postgres my db 

CREATE TABLE people ( id int, name Varchar(10));

INSERT INTO people ( id, name) VALUES (2,'steep');

\q
## exit from psql

docker rm -f postgres1

docker volume ls 

Docker run -d -p  5432:5432  -v postgres-data:/var/lib/postgresql/data  --name postgres2 postgres


docker exec -it postgres1 sh

psql -U postgres my db 

SELECT * FROM People

docker rm -f postgres2

docker volume rm postgress-data

docker logs
