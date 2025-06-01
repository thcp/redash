# Redash Helm Chart

This chart makes it easy to deploy Redash 25.1.0 on Kubernetes. It's tailored for security, scalability, and compatibility — with sensible defaults that work in most real-world scenarios.

## Prerequisites

- Kubernetes 1.21+
- Helm 3.2.0+

## Installing the Chart

To install the chart with the release name `my-redash`:

```bash
helm install redash \
  --namespace redash \
  --create-namespace \
  --values values.yaml \
  .
```

## Configuration

The following table lists the configurable parameters of the Redash chart and their default values.

### Image Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.repository` | Redash image repository | `redash/redash` |
| `image.tag` | Redash image tag | `25.1.0` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `imagePullSecrets` | Image pull secrets | `[]` |

### Redash Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `redash.env.REDASH_SECRET_KEY` | Secret key for cryptographic features | `""` (auto-generated if empty) |
| `redash.env.REDASH_COOKIE_SECRET` | Cookie secret for cryptographic features | `""` (auto-generated if empty) |
| `redash.env.REDASH_HOST` | Base address of Redash instance | `"http://localhost"` |
| `redash.env.PYTHONUNBUFFERED` | Python unbuffered mode | `"0"` |
| `redash.env.REDASH_LOG_LEVEL` | Redash log level | `"INFO"` |
| `redash.env.REDASH_ENFORCE_CSRF` | Enforce CSRF token validation | `"false"` |
| `redash.env.REDASH_ENFORCE_HTTPS` | Enforce HTTPS | `"false"` |

### Web Server Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `redash.web.replicaCount` | Number of web replicas | `2` |
| `redash.web.resources.limits.cpu` | CPU limit for web | `1000m` |
| `redash.web.resources.limits.memory` | Memory limit for web | `1Gi` |
| `redash.web.resources.requests.cpu` | CPU request for web | `500m` |
| `redash.web.resources.requests.memory` | Memory request for web | `512Mi` |
| `redash.web.securityContext` | Security context for web | See values.yaml |
| `redash.web.podDisruptionBudget.minAvailable` | Minimum available pods for web | `1` |
| `redash.web.service.type` | Service type for web | `ClusterIP` |
| `redash.web.service.port` | Service port for web | `80` |
| `redash.web.service.targetPort` | Target port for web | `5000` |

### Worker Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `redash.worker.replicaCount` | Number of worker replicas | `2` |
| `redash.worker.resources.limits.cpu` | CPU limit for worker | `1000m` |
| `redash.worker.resources.limits.memory` | Memory limit for worker | `2Gi` |
| `redash.worker.resources.requests.cpu` | CPU request for worker | `500m` |
| `redash.worker.resources.requests.memory` | Memory request for worker | `1Gi` |
| `redash.worker.securityContext` | Security context for worker | See values.yaml |
| `redash.worker.podDisruptionBudget.minAvailable` | Minimum available pods for worker | `1` |
| `redash.worker.autoscaling.enabled` | Enable autoscaling for worker | `true` |
| `redash.worker.autoscaling.minReplicas` | Minimum replicas for worker autoscaling | `2` |
| `redash.worker.autoscaling.maxReplicas` | Maximum replicas for worker autoscaling | `10` |
| `redash.worker.autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization for worker autoscaling | `80` |
| `redash.worker.autoscaling.targetMemoryUtilizationPercentage` | Target memory utilization for worker autoscaling | `80` |
| `redash.worker.env.WORKERS_COUNT` | Number of worker processes | `"2"` |
| `redash.worker.env.QUEUES` | Comma-separated list of queues | `"queries,scheduled_queries,celery"` |
| `redash.worker.env.REDASH_JOB_EXPIRY_TIME` | TTL in seconds for jobs | `"43200"` (12 hours) |

### Scheduler Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `redash.scheduler.replicaCount` | Number of scheduler replicas | `1` |
| `redash.scheduler.resources.limits.cpu` | CPU limit for scheduler | `500m` |
| `redash.scheduler.resources.limits.memory` | Memory limit for scheduler | `512Mi` |
| `redash.scheduler.resources.requests.cpu` | CPU request for scheduler | `100m` |
| `redash.scheduler.resources.requests.memory` | Memory request for scheduler | `256Mi` |
| `redash.scheduler.securityContext` | Security context for scheduler | See values.yaml |

### Ingress Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.enabled` | Enable ingress | `true` |
| `ingress.className` | Ingress class name | `"nginx"` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts` | Ingress hosts | See values.yaml |
| `ingress.tls` | Ingress TLS configuration | `[]` |

### Mail Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `mail.server` | Mail server hostname | `""` |
| `mail.port` | Mail server port | `25` |
| `mail.useTLS` | Whether to use TLS | `false` |
| `mail.useSSL` | Whether to use SSL | `false` |
| `mail.username` | Mail server username | `""` |
| `mail.password` | Mail server password | `""` |
| `mail.defaultSender` | Default sender email address | `""` |

### SSO Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `sso.enabled` | Enable SSO | `true` |
| `sso.saml.metadataUrl` | SAML metadata URL | `""` |
| `sso.saml.entityId` | SAML entity ID | `""` |
| `sso.saml.callbackUrl` | SAML callback URL | `""` |
| `sso.saml.loginEnabled` | Enable SAML login | `true` |

### Query Runners Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `queryRunners.enabled` | List of query runners to enable | `[]` |
| `queryRunners.disabled` | List of query runners to disable | `[]` |
| `queryRunners.additional` | List of additional query runners | `[]` |

### Alert Destinations Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `alertDestinations.enabled` | List of alert destinations to enable | `[]` |
| `alertDestinations.additional` | List of additional alert destinations | `[]` |

### PostgreSQL Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `postgresql.enabled` | Enable PostgreSQL dependency | `true` |
| `postgresql.auth.username` | PostgreSQL username | `redash` |
| `postgresql.auth.password` | PostgreSQL password | `""` (auto-generated) |
| `postgresql.auth.database` | PostgreSQL database | `redash` |
| `postgresql.primary.persistence.size` | PostgreSQL persistence size | `8Gi` |

**Note:** This chart uses PostgreSQL `13.18.0-debian-12-r2` to ensure full compatibility with Redash 25.1.0.

### Redis Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `redis.enabled` | Enable Redis dependency | `true` |
| `redis.auth.password` | Redis password | `""` (auto-generated) |
| `redis.master.persistence.size` | Redis persistence size | `8Gi` |

**Note:** This chart uses Redis `6.2.16-debian-12-r3` to ensure compatibility and avoid authentication issues with Redash 25.1.0.

### Security Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `serviceAccount.create` | Create service account | `true` |
| `serviceAccount.annotations` | Service account annotations | `{}` |
| `serviceAccount.name` | Service account name | `""` |
| `podSecurityPolicy.enabled` | Enable pod security policy (deprecated in K8s v1.21+) | `false` |
| `rbac.create` | Create RBAC resources | `true` |

## Security Features

This chart implements several security best practices:

1. Non-root container execution using SecurityContext
2. RBAC for proper authorization
3. PodSecurityContext for pod security
4. Secrets for sensitive data
5. Azure AD / Microsoft Entra ID SSO integration using SAML 2.0

## Scalability Features

This chart implements several scalability features:

1. Horizontal Pod Autoscaler (HPA) for redash-worker based on CPU/memory usage
2. Pod Disruption Budget (PDB) for redash-web and redash-worker to maintain availability during node upgrades or maintenance

## Notes

- This chart is compatible with Kubernetes 1.21+ and uses the latest stable API versions
- For production deployments, it's recommended to set proper values for `REDASH_SECRET_KEY`, `REDASH_COOKIE_SECRET`, and `REDASH_HOST`
- External PostgreSQL and Redis can be configured by setting `postgresql.enabled=false` and `redis.enabled=false` and providing external connection details
- For production deployments, it's recommended to enable CSRF protection by setting `redash.env.REDASH_ENFORCE_CSRF=true`
