# K8s 模板说明

## 文件说明

| 文件 | 说明 |
|------|------|
| `deployment.yaml` | 基础 Deployment（无依赖） |
| `deployment-with-deps.yaml` | 有服务依赖时的 Deployment |
| `service.yaml` | ClusterIP Service |
| `ingress.yaml` | Ingress 入口 |

## 服务依赖怎么改

当 A 服务依赖 B 服务（如 api 依赖 db）时，需要做两件事：

### 1. 启动顺序：initContainer 等待依赖就绪

在主容器启动前，用 initContainer 等待依赖 Pod/Service 就绪：

```yaml
initContainers:
  - name: wait-for-db
    image: ghcr.io/groundnuty/k8s-wait-for:v2.0
    args: ["pod", "-lapp=db"]   # 按 label 等 Pod
    # 或 args: ["service", "db"]  # 按 Service 名等
```

**多依赖**：按顺序写多个 initContainer，会依次执行：

```yaml
initContainers:
  - name: wait-for-db
    image: ghcr.io/groundnuty/k8s-wait-for:v2.0
    args: ["pod", "-lapp=db"]
  - name: wait-for-redis
    image: ghcr.io/groundnuty/k8s-wait-for:v2.0
    args: ["pod", "-lapp=redis"]
```

**RBAC**：若 initContainer 报 `Forbidden`，需给 default SA 授权：

```bash
kubectl create role pod-reader --verb=get,list,watch --resource=pods,services
kubectl create rolebinding default-pod-reader --role=pod-reader --serviceaccount=default:default -n default
```

### 2. 连接地址：env 注入依赖 URL

集群内通过 K8s DNS 访问其他 Service：

- 同 namespace：`db` 或 `db.default.svc.cluster.local`
- 跨 namespace：`db.other-ns.svc.cluster.local`

```yaml
env:
  - name: DB_HOST
    value: "db"
  - name: DB_PORT
    value: "5432"
```

### 3. 可选：应用内重试

若不想用 initContainer，也可在应用代码里对依赖做重试（如 teacher-ref 的 worker 连接 db/redis），但 initContainer 更清晰、易排查。
