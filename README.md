# Deploying Prefect on Google Cloud Platform (GCP)
Welcome to the guide on setting up Prefect on GCP. This tutorial provides a step-by-step process to get you started on deploying and running Prefect on the Google Cloud Platform (GCP). 

Just to give you a high-level overview, Prefect requires a polling agent that is continuously checking for work. The tasks can be triggered by cron jobs or manually initiated by the user. The agent then spins up a CloudRun job and executes the Prefect flow. 

Let's dive right in!

## Step 1: Organizing Your Folders
We're going to start by creating and organizing our folders in GCP. I recommend setting up your folders like this: Have a main infrastructure folder which can contain various projects like prefect or jenkins. It's an excellent way to keep your projects neat and organized.

## Step 2: Register and Create API Key on Prefect Website
Next, head on over to the Prefect website and sign up for their services. After you've completed your registration, go to your profile and create an API key. Save it somewhere. Also, make sure to set up a workspace while you're there.

## Step 3: Set Up a VM Instance using Terraform
I'm a fan of Terraform, and for good reason. It allows you to codify your infrastructure setup process and makes future modifications a breeze.

First, enable the VM Instance API for your project. With that done, we need to create a Service Account. A Service Account is how GCP provides users with the access to use GCP resources. For our purposes, we'll need a Service Account with the following roles:

- Compute Instance Admin
- Service Account User

With that set up, we're ready to write our Terraform file and get our infrastructure deployed.

To deploy the infrastructure, enter these commands in your terminal:
```
terraform init
terraform apply --auto-approve
```

After successful deployment, head over to the GCP console and click on VM instances. There, find the instance named prefect, and click on SSH at the top, then on the dropdown, select view gcloud command. Copy this command and run it in your terminal to connect to the VM instance.

Now let's create a new file named startup.sh and open it:
```
touch startup.sh
vim startup.sh
```
Replace your_prefect_api_key_here with your actual PREFECT_API_KEY from the Prefect website in the startup script. If you have a CI/CD pipeline set up, you should pass the PREFECT_API_KEY from there.

Copy the contents of your local startup.sh script into the file on the VM instance, then save and exit. Now we need to make this file executable and run it:
```
chmod +x ./startup.sh 
./startup.sh 
```
*please note ypu can also add contents of startup.sh file into startup scripts in terraform. The script would execute all commands on startup. However this can get trciky.

Now we're all set. Start the agent with the following command:
```
prefect agent start -q default
```
The terminal should show prefect running.


## Step 4: Create a Bucket for Flow Storage
Lastly, we'll need a bucket to store our flows for cloud execution. As my plan is to execute flows using Prefect GCP Cloud Run tasks, this step is crucial.

And voila, you're all set! We've successfully set up a Prefect deployment on GCP. Now you can begin executing your flows on the cloud.
