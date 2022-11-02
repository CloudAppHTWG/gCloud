#!/bin/bash
# create object storage for media files
gcloud services enable storage-api.googleapis.com
echo '-------------------------------------------------------------'
echo "Object Storage enabled"
echo '-------------------------------------------------------------'
# create bucket for media files
gcloud storage buckets create gs://cloud-app-auto-media --project=cloud-app-366313 --default-storage-class=STANDARD --uniform-bucket-level-access --location=EUROPE-WEST3
echo '-------------------------------------------------------------'
echo "Bucket created"
echo '-------------------------------------------------------------'
# show all buckets
gcloud storage buckets list

# delete bucket
gcloud storage buckets delete gs://cloud-app-auto-media

