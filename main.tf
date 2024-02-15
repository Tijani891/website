terraform {
  required_version = ">= 0.13"
  required_providers {
    kubectl = {
        source  = "gavinbunney/kubectl"
        version = "1.14.0"
    }
  }
}
provider "kubectl" {
  config_path = "~/.kube/kind-config-my-kind-cluster"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/kind-config-my-kind-cluster"
  }
}


resource "kubectl_manifest" "my_app_deployment" {
  yaml_body = file("${path.module}/app-depl.yaml")
}

resource "kubectl_manifest" "my_app_service" {
  yaml_body = file("${path.module}/app-svc.yaml")
}


resource "helm_release" "kube_prom" {
  name       = "kube-prometheus-stack"
  chart      = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  set {
    name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
    value = "false"
  }
}