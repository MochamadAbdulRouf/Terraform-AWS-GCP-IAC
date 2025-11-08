# Project Terraform Infrastructure GCP kombinasi dengan Modules

Project Terraform ini berisi Infrastruktur GCP(Google Cloud Platform) dengan resource berikut VM Instances, VPC, Cloud Storage Bucket, dan Bucket Backend.Dibuat menggunakan Modules untuk implementasi yang sempurna dan mudah di modifikasi lagi nantinya.

Cara menggunakan project ini di cloud provider GCP

## Berikut perintah yang secara berurutan saya gunakan 

1. Inisialisasi Project
```bash
terraform init
```

2. Menautkan Instance `tf-instance-1` yang ada di kode 
```bash
terraform import 'module.instances.google_compute_instance.instance_1' 'projects/[PROJECT_ID]/zones/[ZONE]/instances/tf-instance-1'
```

3. Menautkan Instance `tf-instance-2` yang ada di kode 
```bash
terraform import 'module.instances.google_compute_instance.instance_2' 'projects/[PROJECT_ID]/zones/[ZONE]/instances/tf-instance-2'
```

4. Menyesuaikan VM yang ada dengan kode konfigurasi serta menerapkan startup_script,dll.
```bash
terraform apply
```

### Setelah membuat kode Backend GCS dan Migrasi state

5. Setelah menambahkan kode `module "storage"` ke `main.tf`
```bash
terraform init
```

6. Setelah Membuat `GCS Bucket` yang digunakan untuk Backend
```bash
terraform apply
```

7. Setelah menambahkan blok `backend "gcs"` ke file `main.tf` untuk memindahkan state file 
```bash
terraform init -migrate-state
```

### Menambahkan Modul VPC dan Firewall

8. Setelah menambahkan `module "vpc"` 
```bash
terraform init
```

9. Membuat VPC dan Firewall
```bash
terraform apply
```
