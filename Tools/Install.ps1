# See http://stackoverflow.com/questions/6460854/adding-solution-level-items-in-a-nuget-package for original source

param($installPath, $toolsPath, $package, $project)

# Get the open solution.
$solution = Get-Interface $dte.Solution ([EnvDTE80.Solution2])
$solutionPath = Split-Path -parent $solution.FileName
$solutionNameAndExtention = Split-Path -leaf $solution.FileName
$packageFolder = Split-Path -parent $toolsPath
$packageFolderName = Split-Path -leaf $packageFolder

# Create the parent solution folder.
$configFolder = $solution.Projects | where-object { $_.ProjectName -eq ".config" } | select -first 1

if(!$configFolder){$configFolder = $solution.AddSolutionFolder(".config")}
$configPath = "$solutionPath\.config"

# Create VersionInfo.txt if not found
if(!(Test-Path "$configPath\VersionInfo.txt")){New-Item "$configPath\VersionInfo.txt" -force -type file -value "1.0.0.0" > $null}

# Add a file to the child solution folder.
$configItems = Get-Interface $configFolder.ProjectItems ([EnvDTE.ProjectItems])
$versionInfoItem = $configFolder.ProjectItems | where-object { $_.Name -eq "VersionInfo.txt" } | select -first 1
if(!$versionInfoItem){$configItems.AddFromFile("$configPath\VersionInfo.txt") > $null}
