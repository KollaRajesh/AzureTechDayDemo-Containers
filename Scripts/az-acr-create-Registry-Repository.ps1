##Docker images can be stored locally 
##	Use container registers to share images
##	Docker Hub hosts Publish images
##	http://hub.docker.com
##	
##Azure Container Register  (ACR;-)
		##Store container  in Azure 
		## can build images automatically 
		
##docker build -f "\coderep\AzureTechDayDemo-Containers\WebApp1\Dockerfile" --force-rm -t webapp1  --label "com.microsoft.created-by=visual-studio" --label "com.microsoft.visual-studio.project-name=WebApp1" "\coderep\AzureTechDayDemo-Containers\WebApp1" 

## login into azure		
az  login 

## setting subscription

az account set -s mysubscription


$resourceGroup ="azTechDaysACR"

##creating resource group

az group create $resourceGroup

$registryName ="azureTechDaysacr"


##creating azure container registry
az acr create -g $recourceGroup -n $registryName  --sku Basic --admin-enabled true 

	
	##Images not accessible to the public
	##Can restrict access rights
	##Only allow trusted images
	##Automatically update to use latest security updates 

##Pushing image to ACR

##login into registy

az acr login -n $registryName

$loginServer= az acr show -n  $registryName  --query  loginServer --output tsv


$loginServer

docker images -ls 

docker tag webapp:v2 azureTechDays.azurecr.io/webapp:v2

#push image to acr (Azure container registry
docker push $loginserver/samplewebapp:v2
	

##list out all repository in registry

az acr repository  list -n $registryName -o table

# list tag name for given repository
az acr repository  show-tags  -n $registryName --repository  webapp -o table

#cleaning repository
az acr repository  delete -n $registryName  -t webapp:v2

#Cleaning resources
az group delete  -n $resourceGroup -y


