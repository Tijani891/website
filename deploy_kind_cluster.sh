#!/bin/bash
CLUSTER_NAME="my-kind-cluster"

echo "Creating KinD cluster '$CLUSTER_NAME'..."
kind create cluster --name="$CLUSTER_NAME"


echo "Waiting for the cluster to be ready..."
kubectl wait --for=condition=Ready node --all --timeout=300s


echo "KinD cluster '$CLUSTER_NAME' created successfully!"
kubectl cluster-info --context="$CLUSTER_NAME"

kind get kubeconfig --name $CLUSTER_NAME > $HOME/.kube/kind-config-$CLUSTER_NAME