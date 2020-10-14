#!/bin/bash

TF_VAR_org_id=$(gcloud organizations list --format='value(name)' --limit=1)
GOOGLE_ACCOUNT=$(gcloud config get-value account)

gcloud beta organizations add-iam-policy-binding ${TF_VAR_org_id} \
  --member user:${GOOGLE_ACCOUNT} \
  --role roles/compute.xpnAdmin