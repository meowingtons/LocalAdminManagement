import .\lamfunctions.ps1

function Sync-LocalMachine
{
    $Managed = Get-AdminManagedStatus

    if ($Managed)
    {
        $LocalAdmins = Get-MachineAdminMembership
        $ConfiguredAdmins = Get-ConfiguredAdmins
    }
}