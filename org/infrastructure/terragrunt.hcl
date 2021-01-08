# nothing to do here at the moment, as the folder is create as part of the bootstrap.
# an emtpy terragrunt.hcl file is needed though, to allow the terragrunt command to 
# run in this directory

# Include all settings from the root terragrunt.hcl file

include {
  path = find_in_parent_folders("org.hcl")
}