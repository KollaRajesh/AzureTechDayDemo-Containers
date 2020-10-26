##      Create an ACI container group 
           ## Docker image from ACR
          ## Mount an Azure file share 
         ## az container exec

$registryName ="azTechDaysacr"

az acr login -n $registryName

$loginServer= az acr show -n  $registryName  --query  loginServer --output tsv

$loginServer

$acrPassword =az acr credential show -n $registryName  `
                             --query "passwords[0].value" -o tsv


$resourceGroup  ="AzTechDaysAcR"

$location ="eastus"

az group create -n $resouceGroup  -l $location 

##Creating storage account

$storageAccountName ="acishare10232020"


az storage account  create  -g  $resourceGroup  ` 
   -n $storageAccountName `
   --sku  Standard_LRS

#get storageConnectionString
$storageConnectionString =az storage account show-connection-string  `
                                                  -n  $storageAccountName -g $resourceGroup `
                                                 --query connectionstring -o tsv 
# Set environment variable AZURE_STORAGE_CONNECTION_STRING with  storageConnectionString
$env:AZURE_STORAGE_CONNECTION_STRING=$storageConnectionString


#create azure file share
$shareName="acishare"

az storage share create -n $shareName


## Get storage key
$storageKey=$(az storage account keys list ` 
              -g  $resourceGroup  --account-name $storageAccountName `
		      --query  "[0].value"  --output tsv)


##Create container group
$containerGroupName="ghost-blog1"

az container  create -g $resourceGroup  -n $containerGroupName  `
     --image $acrServer/webapp:v2 `
      --cpu 1 --memory 1 `
       --registry-username  $acrName  `
       --registry-password $acrPassword  `
      --azure-file-volume-account-name  $storageAccountName `
      --azure-file-volume-account-key   $storageKey `
      --azure-file-volume-share-name $shareName `
      --azure-file-volume-mount-path  "/home" `
     -e TestSetting=FromAzCli   TestFileLocation=/home/message.txt `
      --dns-name-label  "aciacr1"  --ports 80
  

Az container exec -n $conainerGroupName  -g $resourceGroup  `
     --exec-command sh 

  echo  " Azure Tech Days" > .home/message.txt

az storage file list  -s $shareName  -o table



##Cleaning resources

Az group delete  -n $resourcegroup -y 


