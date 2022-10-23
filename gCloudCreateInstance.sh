#! /bin/bash
gcloud compute instances create cloud-app-auto --image-family=debian-11 --image-project=cloud-app-366313 --metadata-from-file=startup-script=/wo --zone=europe-west3-c >rkspaces/gCloud/initSript.sh
