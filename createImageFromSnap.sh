#! /bin/bash

#create instance from snapshot
gcloud compute instances create cloud-app-auto --zone=europe-west3-c --source-snapshot=cloud-app-auto-snapshot --metadata-from-file=startup-script=initScriptSnap.sh

#attach disk
gcloud compute instances attach-disk cloud-app-auto --disk=cloud-app-auto-volume --zone=europe-west3-c
