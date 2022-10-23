#! /bin/bash
#control tool
while true; do
    echo "Welcome to the control tool"
    echo "Please select an option"
    echo "1. Create instance from srcatch"
    echo "2. Create instance from snapshot"
    echo '3. Start instance'
    echo "4. Stop instance"
    echo "5. Delete instance"
    echo "6. Create snapshot from instance"
    echo "7. Show all instances"
    echo "8. Show all snapshots"
    echo "9. Exit"

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
        echo "Exiting"
        exit
        ;;
    *)
        echo "Invalid option"
        ;;
    esac
done
