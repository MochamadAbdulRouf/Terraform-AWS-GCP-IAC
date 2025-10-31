# Project Terraform Infrastructure GCP kombinasi dengan Modules

Project Terraform ini berisi Infrastruktur GCP(Google Cloud Platform) dengan resource berikut VM Instances, VPC, Cloud Storage Bucket, dan Bucket Backend.Dibuat menggunakan Modules untuk implementasi yang sempurna dan mudah di modifikasi lagi nantinya.

Cara menggunakan project ini di cloud provider GCP

1. Inisialisasi Project
```bash 
terraform init
```

2. Validate Kode sintaks project
```bash
terraform validate
```

3. Membuat plan untuk membandingkan dan resource apa yang akan dibuat 
```bash
terraform plan
```

4. Menerapkan konfigurasi project terraform
```bash
terraform apply
```

5. Untuk menghapus semua resource yang telah di deploy ke GCP
```bash
terraform destroy
```
