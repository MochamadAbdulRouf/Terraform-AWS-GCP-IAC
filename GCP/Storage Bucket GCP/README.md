# Cloud Storage Backend

Command dibawah ini adalah perintah migrasi yang dijalankan setelah mengubah konfigurasi backend di dalam file .tf 
```bash
terraform init -migrate-state
```
Misalnya, jika Anda baru saja menambahkan blok backend "gcs" ke kode untuk beralih dari penyimpanan lokal ke Google Cloud Storage, inilah saatnya Anda menggunakan perintah tersebut.