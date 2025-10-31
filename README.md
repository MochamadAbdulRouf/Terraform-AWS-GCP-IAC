# TERRAFORM
Terraform adalah alat Infrastructure as Code (IaC) untuk membangun, mengubah, dan mengelola infrastruktur secara aman dan efisien. Sederhananya, Anda menulis kode yang mendeskripsikan infrastruktur (server, database, jaringan), dan Terraform akan membangunnya sesuai deskripsi tersebut.Terraform biasanya digunakan untuk membangun Infrastructure di Cloud Provider Seperti AWS (Amazon Web Service) dan GCP (Google Cloud Platform). Dengan Terraform membuat Infrastructure Cloud akan lebih cepat dan mudah.

## Terraform for Building Infrastructure on AWS and GCP
Project ini berisi hasil explore saya mengenai Terraform untuk implementasi pada 2 Cloud Provider yaitu AWS dan GCP, project ini saya kerjakan untuk meningkatkan Pengetahuan dan Skill Teknis saya dalam Dunia DevOps.Saya berharap bisa terus konsisten mengerjakan project ini, Selain Project ini masih banyak Project DevOps lainnya di Repository Github saya.Terimakasih sudah melihat project kecil-kecilan saya ini😃

## Terraform Command

1. `terraform init` adalah perintah untuk menginisialisasi direktori proyek terraform, Supaya Terraform mengunduh providers dan menyiapkan Backend.
```bash
terraform init
```

2. `terraform validate` adalah perintah untuk mengecek sintaks kode `.tf` apakah sudah valid atau benar dan tidak ada kesalahan didalam sintaks kode di proyek terraform
```bash
terraform validate
```

3. `terraform plan` adalah perintah untuk membuat sebuah rencana dengan membandingkan kode di proyek saat ini dengan apa yang tercatat di file state dan apa yang sebenarnya ada di cloud.
```bash
terraform plan
```

4. `terraform apply` adalah perintah untuk menjalankan rencana yang dibuat oleh `terraform plan`. ini adalah perintah yang benar benar akan membuat dan mengubah infrastructure di Cloud.
```bash
terraform apply
```

5. `terraform destroy` adalah perintah untuk menghapus semua infrastructure yang dikelola oleh proyek terrraform tersebut, ini akan membaca file state dan menghapus satu persatu resource yang telah dibuat di Cloud.
```bash
terraform destroy
```
note: mungkin command di atas adalah command yang akan paling sering di terapkan kedepannya ketika membuat sebuah proyek terraform, masih banyak command lain cek di website resmi terraform https://developer.hashicorp.com/terraform/cli/commands 

EST. 2025 Build with ❤️ by Rouf
