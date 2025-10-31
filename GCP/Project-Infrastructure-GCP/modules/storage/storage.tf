# File: modules/storage/storage.tf

resource "google_storage_bucket" "bucket" {
  # Gunakan nama yang persis seperti di instruksi
  name = "tf-bucket-657920"

  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true

  # Catatan: 'project' tidak perlu diisi di sini
  # karena resource ini akan mengambil 'project_id'
  # dari konfigurasi provider di root main.tf Anda.
}