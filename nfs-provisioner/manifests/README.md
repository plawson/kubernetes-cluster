# kubernetes nfs-client-provisioner

NFS provisionner source is at: [https://github.com/kubernetes-incubator/external-storage/tree/master/nfs-client](https://github.com/kubernetes-incubator/external-storage/tree/master/nfs-client)

[![Docker Repository on Quay](https://quay.io/repository/external_storage/nfs-client-provisioner/status "Docker Repository on Quay")](https://quay.io/repository/external_storage/nfs-client-provisioner)

- pv provisioned as ${namespace}-${pvcName}-${pvName}
- pv recycled as archieved-${namespace}-${pvcName}-${pvName}

# deploy
- deploy `deployment.yaml`
- deploy `class.yaml`

## RBAC
```console
$ kubectl create -f auth/serviceaccount.yaml
serviceaccount "nfs-client-provisioner" created
$ kubectl create -f auth/clusterrole.yaml
clusterrole "nfs-client-provisioner-runner" created
$ kubectl create -f auth/clusterrolebinding.yaml
clusterrolebinding "run-nfs-client-provisioner" created
$ kubectl patch deployment nfs-client-provisioner -p '{"spec":{"template":{"spec":{"serviceAccount":"nfs-client-provisioner"}}}}'
```

