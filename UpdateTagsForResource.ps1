$Allinformation = Import-Csv -path C:\temp\Information.csv
foreach ( $singleinfor in $Allinformation ) 
{
$rgname = $singleinfor.ResourceGroup
$vmname = $singleinfor.ServerName
$appname = $singleinfor.updatedApplicationName
$owner = $singleinfor.updatedApplicationOwner
$envir = $singleinfor.UpdatedEnvironment


$tags = (Get-AzResource -ResourceGroupName "$rgname" -Name "$vmname").Tags



$tags.'af-applicationname' = "$appname"
$tags.'af-applicationowner' =  "$owner"
$tags.'af-environment' = "$envir"

Set-AzResource -ResourceGroupName "$rgname" -ResourceName "$vmname" -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags -Force
}
