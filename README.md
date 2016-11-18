# CentralizedVersionInfo
Shared version handling for visual studio projects within a solution

### Usage
* Using sln
Modify .config\VersionInfo.txt to the desired version and build your code
the string inside VersionInfo.txt will be used to update Properties\VersionInfo.cs file inside your csproj

* Build Solution using msbuild
Is you chose to build your solution with msbuild you can pass /p:BuildVersionNumberOverride="78" and this will replace the Build path of the version in Properties\VersionInfo.cs

This requires .config\VersionInfo.txt to be present for the moment

* Build individual csproj or whole sln with msbuild
msbuild /p:asmversion="10.2.5.6"
This will override the Properties\VersionInfo.cs of the csproj or all project using CentralizedVersionInfo in the solution