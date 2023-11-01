$AzDevOpsOrgUrl = "https://dev.azure.com/mgrlabscom"
function New-AzDevOpsProject {
    param(
        [Parameter(Mandatory=$True)] [string] $AzDevOpsProjectName,
        [Parameter(Mandatory=$True)] [string] $AzDevOpsProjectDescription,
        [Parameter(Mandatory=$False)] [string] $AzDevOpsProjectProcess = "Basic",
        [Parameter(Mandatory=$False)] [string] $AzDevOpsProjectVisibility = "private"
    )

    az devops project create `
        --name $AzDevOpsProjectName `
        --description $AzDevOpsProjectDescription `
        --org $AzDevOpsOrgUrl `
        --process $AzDevOpsProjectProcess `
        --source-control "git" `
        --visibility $AzDevOpsProjectVisibility
}

function Remove-AzDevOpsProjects {
    $ProjectIds = (az devops project list --org $AzDevOpsOrgUrl --query 'value[].id' -o tsv)
    foreach  ($Id in $ProjectIds){
        $ProjectName = (az devops project show --project $Id --org $AzDevOpsOrgUrl --query 'name' -o tsv)
        Write-Host "Remove Project:" $ProjectName
        az devops project delete --id $Id --org $AzDevOpsOrgUrl
    }
}