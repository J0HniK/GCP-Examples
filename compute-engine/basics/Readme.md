>Codespaces: Rebuild Container - rebuild container from VScode

gcloud auth login

gcloud config list project

cd compute-engine/basics

terraform init

In Servise Accounts Add permissions: "Compute Instacne Admin (v1)", "OSPolicyAssignment Admin", "Service Account User" 

gcloud iam service-accounts keys create terraform-key.json \
  --iam-account=terraform-sevice-account@learning-12613.iam.gserviceaccount.com

export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/terraform-key.json"

terraform plan

terrafrom apply

Create a fireawall rule in Firewall polices to allow http/s traffic for port 80




terraform state list - check list of running instances

terraform destroy - remove the all instances

Debugging:
gcloud compute instances get-serial-port-output INSTANCE --zone=europe-west1-c         - This command shows the serial console output of your VM
