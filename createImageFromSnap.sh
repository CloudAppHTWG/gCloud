#! /bin/bash
#create instance from snapshot
gcloud compute instances create cloud-app-auto --zone=europe-west3-c --source-snapshot=cloud-app-auto-snapshot
