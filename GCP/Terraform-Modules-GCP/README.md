# Terraform Modules GCP (Google Cloud Platform)
Module adalah sebuah wadah untuk sekumpulan resource Terraform yang digunakan bersama-sama. Tujuannya adalah untuk mengemas konfigurasi menjadi komponen yang bisa digunakan kembali (reusable). Jadi analoginya seperti ini dari pada membangun server dari Nol, Bisa menggunakan Module yang berisi semua konfigurasi yang diperlukan.Jadi hanya dengan memanggil Module, server bisa di bangun kapanpun saat dibutuhkan.
 
## Menggunakan Module Public || Folder = (terraform-google-network)

1. Clone Repo GCP Terraform dari Google
```bash
git clone https://github.com/terraform-google-modules/terraform-google-network
cd terraform-google-network
git checkout tags/v6.0.1 -b v6.0.1
```

2. Di file "variable.tf" isi project menggunakan Project ID di bagian "default"
```bash
variable "project_id" {
  description = "The project ID to host the network in"
  default     = "qwiklabs-gcp-00-63ea5c371a45"
}
```

3. Buat variable baru untuk "network_name"
```bash
variable "network_name" {
  description = "The name of the network to be created"
  default     = "example-vpc"
}
```

- Di file main.tf ganti variable "network_name" menjadi "var.network_name"
- Lalu ubah semua region di main.tf menjadi "us-east1"
note : Jika saat "terraform apply" ada log memasukan project ID maka masukan saja Project ID GCP dan selanjutnya Ketik "yes" untuk Penerapan langsung.

4. Eksekusi Module Publik
```bash
terraform apply
```

5. Outputnya yang keluar harusnya begini 
```bash
Outputs:
network_name = "example-vpc"
network_self_link = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-a68489b0625b/global/networks/example-vpc"
project_id = "PROJECT_ID"
route_names = []
subnets_flow_logs = [
  false,
  true,
  true,
]
subnets_ips = [
  "10.10.10.0/24",
  "10.10.20.0/24",
  "10.10.30.0/24",
]
subnets_names = [
  "subnet-01",
  "subnet-02",
  "subnet-03",
]
```

## Build Module Local (gcs-static-website)

1. Inisialisasi Module
```bash
terraform init
```

2. Ekseskusi Module
```bash
terraform apply
```
note: Respon yes untuk penerapan eksekusi Resource

### Test Cloud Storage Bucket
3. Download sample content
```bash
cd ~
curl https://raw.githubusercontent.com/hashicorp/learn-terraform-modules/master/modules/aws-s3-static-website-bucket/www/index.html > index.html
curl https://raw.githubusercontent.com/hashicorp/learn-terraform-modules/blob/master/modules/aws-s3-static-website-bucket/www/error.html > error.html
```

4. Copy file untuk di upload ke Bucket
```bash
gsutil cp *.html gs://PROJECT_ID
```

5. Pergi ke Browser salin dan masukan
```bash
https://storage.cloud.google.com/YOUR-BUCKET-NAME/index.html
```
note: Ganti "YOUR-BUCKET-NAME" Menjadi nama "PROJECT_ID" karena untuk nama bucket di Konfigurasi Terraform memasukan nama PROJECT ID.
