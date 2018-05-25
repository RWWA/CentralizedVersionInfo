# CentralizedVersionInfo
Shared version handling for visual studio projects within a solution

## Usage
### Build using msbuild
* Build csproj instead of sln
  > If you build the project on its own then SolutionDir will not be set as a property in MsBuild. Same applies if using dotnet.exe build *.csproj.
  > To use the central .config\VersionInfo.exe make sure to pass /p:SolutionDir="SolutionPathHere" as an argument when building csproj individually.
  > If using dotnet.exe build /p:BuildVersionNumberOverride and /p:asmversion will still work on the local project version even without a solution. Starting Version will be the one set inside the csproj.

* Override build part in the version number

  > If you chose to build your solution with msbuild you can pass /p:BuildVersionNumberOverride="78" and this will replace the Build part of the version in Properties\VersionInfo.cs

  > This requires .config\VersionInfo.txt to be present in the solution with the version string (eg: "10.2.0.0").

* Override entire version info

  > msbuild /p:asmversion="10.2.5.6"

* Generate version info without passing override properties

  > When doing a rebuild the version info is set even though no properties are passed to msbuild.

  > This requires .config\VersionInfo.txt to be present in the solution with the version string (eg: "10.2.50.1").

  > This will override the version info in Properties\VersionInfo.cs.

### Build using Visual Studio

> When doing a rebuild in Visual Studio the version info is set even though no properties are passed to msbuild.

> This requires .config\VersionInfo.txt to be present in the solution with the version string (eg: "10.2.50.1").

## How it works
1. If .config\VersionInfo.txt exists
    1. Version info is read from .config\VersionInfo.txt
    1. Parse version info into the 4 parts.
    1. If $(BuildVersionNumberOverride) is passed override the build number part in the version
1. If $(asmversion) is present override the whole version info with value from asmversion
1. If $(BuildVersionNumberOverride) or $(asmversion) was present or target rebuild was invoked then update AssemblyInfo.cs files with the new version info.
