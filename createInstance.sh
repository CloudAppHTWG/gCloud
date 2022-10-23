#! /bin/bash
# Create a new instance in the cloud
gcloud compute instances create cloud-app-auto --image-project=debian-cloud --image-family=debian-10 --metadata-from-file=startup-script=initSript.sh --zone=europe-west3-c
#create snapshot from instance
#gcloud compute disks snapshot cloud-app-auto --snapshot-names cloud-app-auto-snapshot --zone=europe-west3-c

# Open port 80 and 3000
#gcloud compute firewall-rules create nodeendpoint --allow tcp:3000
#gcloud compute firewall-rules create defaultcp --allow=tcp:80 --description="Allow incoming traffic on TCP port 80" --direction=INGRESS
