#!/bin/bash
set -e -o pipefail

echo "Fetching IAM github-action-user ARN"
userarn=$(aws iam get-user --user-name github-action-user | jq -r .User.Arn)

# Download tool for manipulating aws-auth
echo "Downloading tool..."
curl -X GET -L https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.6.29/aws-iam-authenticator_0.6.29_windows_amd64.exe -o aws-iam-authenticator.exe
chmod +x aws-iam-authenticator.exe

echo "Updating permissions"
start aws-iam-authenticator.exe add user --userarn="${userarn}" --username=github-action-role --groups=system:masters --kubeconfig="C:/Users/aishw/.kube/config"

echo "Cleaning up"
rm aws-iam-authenticator.exe
echo "Done!"