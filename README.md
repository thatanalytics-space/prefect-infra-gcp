# prefect-infra-gcp
This repository explains how to deploy prefect on GCP.

Giving a 30,000 feet overview prefect needs a polling agent that continously polling for work. Task can be forwarded to the agent by cron based triggers or initiated by user.

The agent then spins up a CloudRun job and executes the prefect flow.
___

## Setting up correct folders structure
The first part is to create folders with GCP. I prefer organising my folders like
infrastructure which will have projects like prefect or jenkins.
___
## Head to Prefect website - register and create API key and workspace
Head on to prefect website and sign up for the service. Once signed up, head on to your profile and create API KEY and workspace. 
___

## Create an VM instance - Terraform
I prefer doing stuff by terraform way. This help us codify the process and makes it easier to make changes if we ever have to in future. 

We'll start by enabling VM Instance API for the project. Once this is done we need to create a service account.

Service Account is GCP's way of giving users access to utilise GCP resources. For our cases we need a service account with following roles:
- Compute Instance Admin
- Service Account User

Once this is done we are ready to create a terraform file to deploy a our infrastructure.

To deloy infrastructure
```
terraform init
terraform apply --auto-approve
```

Once this is successfully deployed, head on to console and VM instances and click on instance named `prefect`. On the top you can see `SSH`, click on the drop down `view gcloud command`. Now copy this command to clip board and run that command into terminal.

This should connect you to the VM instance.
Now create a new file named startup.sh and go into the file
```
touch startup.sh
vim startup.sh
```
Open the startup script and replace `your_prefect_api_key_here` with PREFECT_API_KEY you got from prefect website.

If you have a CI/CD pipeline implemented, you should pass `PREFECT_API_KEY` from it.

Now copy the contents of startup.sh script into the file in VM instance. Save and Exit.
Up next we need to make this file executable and run this file.
```
chmod +x ./startup.sh 
./startup.sh 
```

We are ready now. Execute the agent using the follwing commands
```
prefect agent start -q default
```
____

## Lastly, create a bucket for saving flows
We'll need a bucket to save our flows to inorder to execute them over the cloud. Since my plan is to execute my flows using prefect gcp cloud run blocks, this step is required. 
