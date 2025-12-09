# Deployment EKS (Elastic Kubernetes Service)

How to running this file?
1. initialization project
```bash
terraform init
```

2. formatting the code
```bash
terraform fmt
```

3. Validate sintaks code
```bash
terraform validate
```

4. Make plan
```bash
terraform plan
```

5. Implement the resource 
```bash
terraform apply
```

6. Make the cluster is active, example like this:
```bash
aws eks describe-cluster --name my-eks-cluster --region ap-southeast-1 --query "cluster.status"
```

7. Connect the cloud shell to cluster, example:
```bash
aws eks update-kubeconfig --region ap-southeast-1 --name my-eks-cluster
```

8. Verification connection cloudshell to cluster
```bash
kubectl get nodes
```

9. The output should look like this
```bash
kube $ kubectl get nodes
NAME                         STATUS   ROLES    AGE   VERSION
ip-10-0-2-241.ec2.internal   Ready    <none>   44m   v1.34.2-eks-ecaa3a6
ip-10-0-3-222.ec2.internal   Ready    <none>   44m   v1.34.2-eks-ecaa3a6
```
