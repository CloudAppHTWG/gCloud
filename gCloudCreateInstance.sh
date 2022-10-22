 #! /bin/bash
gcloud compute instances create cloud-app-auto \
  --image-project=debian-cloud \
  --image-family=debian-10 \
  --metadata-from-file=startup-script=/home/crispychris/Documents/initSript.sh
  --machine-type=e2-small
  --zone=europe-west3-c
