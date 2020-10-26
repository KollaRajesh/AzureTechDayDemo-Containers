docker pull nginx

###Creating container \running image
docker run nginx:latest
docker container 
docker ps 

##Port mapping 
docker run -d -p 8080:80 nginx:latest

docker run -d -p 3000:80 nginx:latest

docker run -d -p 3000:80  -p 3000:80  nginx:latest

docker run --name test-nginx -v /test/content:/usr/share/nginx/html:ro -d nginx


##Delete all contains in single command 
docker rm   $(docker ps -aq)


##Named containers
docker run -d -p 3000:80  -p 3000:80  nginx:latest -n ngWebsite

docker run --name website1 -d -p 3000:80  nginx:latest

##Format output
docker ps --format="ID\t{{.ID}}\nNAME\t{{.Names}}\nIMAGE\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n"


$FORMAT="ID\t{{.ID}}\nNAME\t{{.Names}}\nIMAGE\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n"

docker ps --format=$FORMAT

##Volumes

 ##Allows sharing  of data , files  & Folder 
 ##between host and container 
   ##And also between containers

docker run --name website -v $(pwd):/usr/share/nginx/html:ro -d -p 8080:80 nginx:latest

docker run --name website -v /wsl/docker-desktop-data/version-pack-data/community/docker/volumes/website:/usr/share/nginx/html:ro -d -p 8080:80 nginx:latest

docker exec -it website bash

## bash inside container
ls -al


Cd /usr/share/nginx/html/
ls -al
touch about.html
docker rm  website -f

docker run --name website -v /wsl/docker-desktop-data/version-pack-data/community/docker/volumes/website:/usr/share/nginx/html:/usr/share/nginx/html -d -p 8080:80 nginx:latest
docker exec -it website bash

## bash inside container

Cd /usr/share/nginx/html/
touch about.html

docker run --name website-clone  --volumes-from website -dp 4041:80  nginx
