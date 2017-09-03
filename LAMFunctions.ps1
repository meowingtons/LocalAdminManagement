function Get-AdminManagedStatus
{

    $GroupManagedStatus = (Get-ItemProperty -Path HKLM:\SOFTWARE\LAM).GroupManagedStatus
    If ($GroupManagedStatus -eq 1) {
        return  $true
    }
    else {
        return $false
    }
}

function Get-MachineAdminMembership 
{
    $WellKnownSID = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-544")
    $LocalGroup = ($WellKnownSID.Translate([System.Security.Principal.NTAccount])).ToString().Trim("BUILTIN\")
    $Group = [ADSI]"WinNT://$env:COMPUTERNAME/$LocalGroup,group"

    $LocalAdmins = $group.psbase.invoke("Members")
    $LocalAdminDetails = @()
    $LocalAdmins | ForEach-Object {
        $username = ([ADSI]$_).InvokeGet('Name')
        $bytes = ([ADSI]$_).InvokeGet('ObjectSid')
        $sid = New-Object Security.Principal.SecurityIdentifier ($bytes, 0)

        $LocalAdminProperties = @{
            'Username' = $username;
            'sid' = $sid.ToString()
        }

        $LocalAdminDetails += New-Object -TypeName psobject -Property $LocalAdminProperties
    }

    Return $LocalAdminDetails
}

function  Get-DomainInfo
{
    $ComputerSystem = Get-WmiObject win32_computersystem
    
    If ($ComputerSystem.PartofDomain -eq $true)
    {
        $Global:DomainName = $ComputerSystem.Domain
    }
    Else 
    {
        Throw "Machine is not part of domain. Get wrekt."
    }
}

function Get-ConfiguredAdmins
{
    $Searcher = [adsisearcher]''
    $Searcher.PropertiesToLoad.Add('lamConfiguredAdmins')
    $Searcher.Filter = "(&(objectCategory=Computer)(samAccountName=$env:COMPUTERNAME))"

    $SearchResults = $Searcher.FindAll()

    if ($SearchResults -gt 1)
    {
        throw "More than one object found. (WTF did you do?!)"
    }
    else {
        return $SearchResults
    }
}