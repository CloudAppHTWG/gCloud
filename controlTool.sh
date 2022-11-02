#! /bin/bash
#control tool
echo '-------------------------------------------------------------'
echo "Welcome to the control tool for Cloud Application Development (gcloud cli)"
echo '-------------------------------------------------------------'
while true; do
    echo "Please select an option"
    echo "1. Create instance from srcatch"
    echo "2. Create instance from snapshot"
    echo '3. Start instance'
    echo "4. Stop instance"
    echo "5. Delete instance"
    echo "6. Create snapshot from instance"
    echo "7. Show all instances"
    echo "8. Show all snapshots"
    echo '-------------------------------------------------------------'
    echo "gcloud setup"
    echo "9. install gcloud"
    echo "10. gloud init"
    echo '-------------------------------------------------------------'
    echo "Object Storage"
    echo "11. Create Object Storage"
    echo "12. Delete Object Storage"
    echo "13. Show all Object Storage"
    echo "14. Enable public access to Object Storage"
    
    echo "15. Exit"
    
    
    
    read option
    #case statement
    case $option in
        1)
            echo "Creating instance from scratch"
            gcloud compute instances create cloud-app-auto --image-project=debian-cloud --image-family=debian-10 --metadata-from-file=startup-script=initSript.sh --zone=europe-west3-c
            #attach disk
            gcloud compute instances attach-disk cloud-app-auto --disk=cloud-app-auto-volume --zone=europe-west3-c
            echo 'Want to ports 80 and 3000 ? (y/n)'
            read ports
            if [ $ports = 'y' ]; then
                gcloud compute firewall-rules create nodeendpoint --allow tcp:3000
                gcloud compute firewall-rules create defaultcp --allow=tcp:80 --description="Allow incoming traffic on TCP port 80" --direction=INGRESS
            else
                echo "No chages made"
            fi
        ;;
        2)
            echo "Creating instance from snapshot"
            gcloud compute instances create cloud-app-auto --zone=europe-west3-c --metadata-from-file=startup-script=initScriptSnap.sh --source-snapshot=cloud-app-auto-snapshot
            #attach disk
            gcloud compute instances attach-disk cloud-app-auto --disk=cloud-app-auto-volume --zone=europe-west3-c
        ;;
        3)
            echo "Starting instance"
            gcloud compute instances start cloud-app-auto --zone=europe-west3-c
        ;;
        4)
            echo "Stopping instance"
            gcloud compute instances stop cloud-app-auto --zone=europe-west3-c
        ;;
        5)
            echo "Deleting instance"
            gcloud compute instances delete cloud-app-auto --zone=europe-west3-c
        ;;
        6)
            echo "Creating snapshot from instance"
            gcloud compute disks snapshot cloud-app-auto --snapshot-names cloud-app-auto-snapshot --zone=europe-west3-c
        ;;
        7)
            echo "Showing all instances"
            gcloud compute instances list
        ;;
        8)
            echo "Showing all snapshots"
            gcloud compute snapshots list
        ;;
        
        9)
            echo "install gcloud"
            curl -sSL https://sdk.cloud.google.com | bash
            echo "please restart terminal"
        ;;
        
        10) echo "gcloud init"
            gcloud init
        ;;
        11)
            echo "Create Object Storage"
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
        ;;
        12)
            echo "Delete Object Storage"
            gcloud storage buckets delete gs://cloud-app-auto-media
        ;;
        13)
            echo "Show all Object Storage"
            gcloud storage buckets list
        ;;
        14)
            echo "Enable public access to Object Storage"
            gsutil iam ch allUsers:objectViewer gs://cloud-app-auto-media
        ;;
        15)
            echo "Exiting"
            exit
        ;;
        *)
            echo "Invalid option"
        ;;
    esac
done
