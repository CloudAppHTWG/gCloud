#! /bin/bash
# Create volume
gcloud compute disks create cloud-app-auto-volume --size=10GB --zone=europe-west3-c
# attach volume to instance
gcloud compute instances attach-disk cloud-app-auto --disk=cloud-app-auto-volume --zone=europe-west3-c
# format volume
#gcloud compute ssh cloud-app-auto --zone=europe-west3-c --command="sudo mkfs.ext4 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb"
# mount volume
gcloud compute ssh cloud-app-auto --zone=europe-west3-c --command="sudo mount -o discard,defaults /dev/sdb /mnt/data"
