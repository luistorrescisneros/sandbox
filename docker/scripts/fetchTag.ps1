<#
.SYNOPSIS
	This script fetches the latest tag in GitHub and increases correspondingly the build number
.DESCRIPTION
	This PowerShell script creates a new tag in a Git repository.
.PARAMETER TagName
	Specifies the new tag name
.PARAMETER targetBranch
	Specifies the branch for the tag
.EXAMPLE
	PS> ./fetchTag "target branch"
.NOTES
	Original Author: Luis Torres Cisneros 
	            -luistorres.cisneros@thermofisher.com
#>

param([Parameter(Position=0)][string]$targetBranch = "")

#try {

$latestTag="v0.0.0.0"
if([string]::IsNullOrEmpty($targetBranch))
{
    Write-Output "Branch is empty, tag set to $latestTag"
    Write-Output "latest Tag: $latestTag"
}
else
{   
    $latestTag =$(git describe --tags --abbrev=0) 
    Write-Output "Branch is not empty, tag set to $latestTag"

    if($latestTag -ne "v0.0.0.0")
    {
        Write-Output "latest Tag: $latestTag"
        $Major = $latestTag.Split(".")[0]
        $Major = [int]$Major.Split("v")[0]
        $Minor = [int]$latestTag.Split(".")[1]
        $Patch = [int]$latestTag.Split(".")[2]
        $Build = [int]$latestTag.Split(".")[3]
    
        $Build = $Build + 1

        $latestTag = "v$Major.$Minor.$Patch.$Build"

        Write-Output "latest Tag: $latestTag"

    }

}

echo "$latestTag"

#if ($lastExitCode -ne "0") { throw "Error: Tag was not properly fetched!" }
