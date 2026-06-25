resource "helm_release" "external_dns" {
  name             = "external-dns"
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  chart            = "external-dns"
  namespace        = "external-dns"
  create_namespace = true

  values = [
    yamlencode({
      provider = "aws"
      aws = {
        region = var.region
      }
      serviceAccount = {
        name = "external-dns"
      }
      txtOwnerId = var.cluster_name
    })
  ]

  depends_on = [
    aws_eks_node_group.eks_node_group,
    aws_eks_addon.core_dns
  ]
}

resource "helm_release" "external_secrets" {
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  namespace        = "external-secrets"
  create_namespace = true

  depends_on = [
    aws_eks_node_group.eks_node_group,
    aws_eks_addon.core_dns
  ]
}

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true

  values = [
    yamlencode({
      installCRDs = true
    })
  ]

  depends_on = [
    aws_eks_node_group.eks_node_group,
    aws_eks_addon.core_dns
  ]
}

resource "helm_release" "traefik" {
  name             = "traefik"
  repository       = "https://helm.traefik.io/traefik"
  chart            = "traefik"
  namespace        = "traefik"
  create_namespace = true

  values = [
    yamlencode({
      service = {
        type = "LoadBalancer"
      }
    })
  ]

  depends_on = [
    aws_eks_node_group.eks_node_group,
    aws_eks_addon.core_dns
  ]
}

resource "helm_release" "argo_cd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argo-cd"
  create_namespace = true

  depends_on = [
    aws_eks_node_group.eks_node_group,
    aws_eks_addon.core_dns
  ]
}
