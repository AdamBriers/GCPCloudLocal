# Placeholder for README

## Notes

- Note that that any consumer Service Projects created under the various folders, e.g. 'dev', are dependent upon / linked directly to the Shared VPC Host project, specifically its project_id.  Normally in IaC it would be preferable to get this project_id directly from the IaC resposible for creating this project, but in this case it would mean cross referencing across environments, e.g. from  'dev' to 'infrastructure' in this case.  This would create dependencies between environments, which is not ideal.  To work around this the project_id of the Shared VPC Host project that has been created in the 'infrastructure' environment has been hard coded into the 'org/org.tfvars' file as 'host_project_id'.