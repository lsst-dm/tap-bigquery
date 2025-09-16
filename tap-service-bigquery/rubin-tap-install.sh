# Create GCP and Kubernetes Service Accounts
SA_NAME=tap-sa
PROJECT_ID=ppdb-dev-438721

if ! gcloud iam service-accounts describe ${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com; then
    gcloud iam service-accounts create ${SA_NAME}
else
    echo "${SA_NAME} already existings in GCP.  Not creating"
fi

if ! kubectl get sa ${SA_NAME}; then
    kubectl create serviceaccount --namespace tap-bigquery ${SA_NAME}
else
    echo "${SA_NAME} already exists in GKE.  Not creating"
fi

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member "serviceAccount:${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/bigquery.dataViewer"


gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member "serviceAccount:${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/bigquery.jobUser"


gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member "serviceAccount:${SA_NAME}@$PROJECT_ID.iam.gserviceaccount.com" \
    --role "roles/bigquery.readSessionUser"
    
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member "serviceAccount:${SA_NAME}@$PROJECT_ID.iam.gserviceaccount.com" \
    --role "roles/cloudsql.client"

# Set Workload Identity Bindings

gcloud iam service-accounts add-iam-policy-binding  \
    --role roles/iam.workloadIdentityUser \
    --member "serviceAccount:${PROJECT_ID}.svc.id.goog[default/${SA_NAME}]" \
    ${SA_NAME}@$PROJECT_ID.iam.gserviceaccount.com

kubectl annotate serviceaccount \
    --namespace tap-bigquery ${SA_NAME} \
    iam.gke.io/gcp-service-account=${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com


gcloud iam service-accounts add-iam-policy-binding tap-sa@ppdb-dev-438721.iam.gserviceaccount.com \
  --role roles/iam.workloadIdentityUser \
  --member "serviceAccount:ppdb-dev-438721.svc.id.goog[tap-bigquery/tap-sa]"
