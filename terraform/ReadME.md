# Azure Resume Infrastructure created with Terraform (IAC)

* Documentation: https://developer.hashicorp.com/terraform?product_intent=terraform

## Steps for creating structure:

1. Download Terraform https://developer.hashicorp.com/terraform/install#windows
2. Place terraform.exe outside the root folder of your project because it is a large file for Github
3. Add in Environmental Variables the folder of where the terraform.exe file is located
    Example:
    * C:\Users\Federico Mencuccini\Aplicaciones\Azure Projects\azure-resume\terraform
 
4. Change the variables names of the services in the resume.auto.tfvars file to the ones you like
5. Execute main.tf and wait for everything to create
6. Deploy the function in the backend/api folder from your VS Code to the Function APP
7. Enable Access-Control-Allow-Credentials in CORS in the function


## Understanding each terraform file:
    * main.tf (File which creates each resource)
    * variables.tf (File which has the variable types (string) and names established in each resource of the main.tf file)
    * resume.auto.tfvars (File which contains the names you would like to call the services, each type you have selected and all the string settings which can be established)

From main.tf file it "GETS" the value in the resume.auto.tfvars file

To have Terraform automatically load a variables file, it needs to be named terraform.tfvars. However, if you've named the file differently, you can avoid manually specifying it with terraform apply -var-file="resume.tfvars" by renaming the file with the .auto.tfvars extension. 

This tells Terraform to automatically use it as the default variables file when you run terraform apply, without the need for additional flags


## Links used for understanding how to use:

* https://spacelift.io/blog/how-to-install-terraform
* https://terraformguru.com/terraform-certification-using-azure-cloud/50-Terraform-Azure-Static-Website/



## Terraform Commands 

terraform init
terraform plan
terraform apply --auto-approve
terraform destroy --auto-approve
terraform apply -var-file="resume.tfvars"

The --auto-approve is for skipping to confirm the process, if you do not put it will ask you "if you are sure in continuing"
