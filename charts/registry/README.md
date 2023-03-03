Chart for Consul for testing JHipster

## Cheatsheet

```bash
> helm template rollout . --namespace rollout -f rollout-values.yaml > manifest.yaml
> helm template rollout namesjc/rollout -n rollout -f vaules.yaml > manifests.yaml
```

helm upgrade

```bash
> helm upgrade -n rollouts rollouts namesjc/rollouts --reuse-values --set image.tag=yellow
```


