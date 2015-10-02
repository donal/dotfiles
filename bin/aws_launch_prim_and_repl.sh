#!/bin/bash
# Argument = -e AWS_ENV -u EC2_INSTANCE_USER

usage()
{
cat << EOF
usage: $0 options

This script launches two EC2 instances, one primary and one replica (in
separate AZs within the ap-southeast-1a, Singapore, region).

OPTIONS:
   -v      The GitHub Enterprise version.
EOF
}

GHE_VERSION=
GHE_VERSION_LATEST=233

# ugh not supported in bash < 4
declare -a GHE_VERSION_AMIS
GHE_VERSION_AMIS[230]="ami-e8e9e5ba"
GHE_VERSION_AMIS[231]="ami-c0929d92"
GHE_VERSION_AMIS[232]="ami-d0515982"
GHE_VERSION_AMIS[233]="ami-a2cedbf0"

PRIMARY_SUBNET="subnet-c09643a5"
PRIMARY_IP="54.169.150.161"
REPLICA_SUBNET="subnet-5000e927"
REPLICA_IP="54.169.218.104"

while getopts “v:” OPTION
do
     case $OPTION in
         v)
             GHE_VERSION=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [ -z "$GHE_VERSION" ]; then
  GHE_VERSION=${GHE_VERSION_LATEST}
fi

GHE_AMI=${GHE_VERSION_AMIS[$GHE_VERSION]}

if [ -z "$GHE_AMI" ]; then
  echo "The GHE version ${GHE_VERSION} isn't supported."
  exit
fi

echo "Lauching primary"

# aws ec2 run-instances --security-group-ids sg-1e7eb47b --subnet ${PRIMARY_SUBNET} --instance-type r3.large --image-id ${GHE_AMI} --block-device-mappings '[{"DeviceName":"/dev/xvdf","Ebs":{"VolumeSize":20,"VolumeType":"gp2"}}]' --region ap-southeast-1 --key-name DonalKeyPair --associate-public-ip-address ${PRIMARY_IP}

aws ec2 run-instances --security-group-ids sg-1e7eb47b --subnet ${PRIMARY_SUBNET} --instance-type r3.large --image-id ${GHE_AMI} --block-device-mappings '[{"DeviceName":"/dev/xvdf","Ebs":{"VolumeSize":20,"VolumeType":"gp2"}}]' --region ap-southeast-1 --key-name DonalKeyPair

echo "Lauching replica"

aws ec2 run-instances --security-group-ids sg-1e7eb47b --subnet ${REPLICA_SUBNET} --instance-type r3.large --image-id ${GHE_AMI} --block-device-mappings '[{"DeviceName":"/dev/xvdf","Ebs":{"VolumeSize":20,"VolumeType":"gp2"}}]' --region ap-southeast-1 --key-name DonalKeyPair

