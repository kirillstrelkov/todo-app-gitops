# GitOps for todo app

Todo app can be found <https://github.com/kirillstrelkov/KubernetesSubmissions/>

This repo contains config for Kubernetes.

## Overview

### Staging

![alt text](./docs/diag_stage.png "Overview")

### Production

![alt text](./docs/diag_prod.png "Overview")

## ArgoCD applications

Create ArgoCD applications

```bash
make argocd
```

### Staging

![alt text](./docs/argocd_app_staging.png "ArgoCD app staging")

### Production

![alt text](./docs/argocd_app_prod.png "ArgoCD app prod")
