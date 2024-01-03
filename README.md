# scc-infra

These are the Azure templates that make up the SunCoast Cloud internal infrastructure consisting of the following services:

-Single static web page hosted in an Azure blob container using the Azure Front door service. 
Making changes to any of the files under the scc-infra local repository pushes a GitHub Actions workflow that uploads the files to the storage account.

-Storage Account for Azure CloudShell and static web page

-Public DNS Zone for suncoastcloud.co
