##Creating Container Groups with the Azure CLI
## syntax
az container  create -n my containergroup -g my resourcegroup --image someimage:sometag `
   --ip=address public `
   --dns-name-label my site  ` # my sit.eastus.azurecontainer.io
  --ports 80 `
  --os-type Windows ` # default is Linux
 -e  name=value `
 --restart-policy  never ` #always , onfailure
--azure -file-volume    #credentials , mount path  , share-name

###########################################################################33  
  
  
##DEMO
    ## Create an ACI container group 
    ##     - Ghost blog 
    ##     - az group  create 
    ##    - az contianer create 
    ##    - az  container logs 
    ##    - az group delete 
    ##

$resourceGroup= "azTechDaysAcR"
$location="eastus"

az group create -n $resourceGroup -l $location

$containerGroupName="ghost-blog1"
 
az container  create -g $resourceGroup  -n $containerGroupName  `
     --image ghost `
     --ports 2668 `
    --ip-address public `
   --dns-name-label ghostaci1


az container logs -n $containerGroupName -g  $resourceGroup
  
##cleaning resources
az group delete -n $resourceGroup -y

##======================================================================
