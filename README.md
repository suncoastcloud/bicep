# Azure ARM Template and Bicep Samples

These are the Azure templates and files that make up the SunCoast Cloud internal infrastructure consisting of the following services:

-Single static web page hosted in an Azure blob container using the Azure Front door service. 
Changes that are made to any of the local files under the scc-infra repository get pushed to GitHub then trigger a GitHub Actions workflow that uploads and overwrites the files to the storage account.

-Storage Account for Azure CloudShell and static web page.

-Public DNS Zone for suncoastcloud.co
