## Implementasi Instance.tf (GCP Terraform Fundamental)

1. Mengaktifkan fitur Asisten Ai (Gemini) Di Project GCP Melalui API
```bash
student_04_6a1c3bdac312@cloudshell:~ (qwiklabs-gcp-00-7a33fa0d060a)$ gcloud services enable cloudaicompanion.googleapis.com
Operation "operations/acat.p2-460098614643-25009a74-4f58-4bd3-998b-276a94d9d97e" finished successfully.
```

2. Melakukan inisialisasi ke project Terraform, Ini membuat Terraform menguduh API Cloud Provider yang terdapat di file, Untuk berkomunikasi antara Terraform dengan Cloud Provider.
```bash
student_04_6a1c3bdac312@cloudshell:~ (qwiklabs-gcp-00-7a33fa0d060a)$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/google...
- Installing hashicorp/google v7.6.0...
- Installed hashicorp/google v7.6.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

3. Melakukan Planning/Rencana tentang Resource apa saja nanti yang akan dibuat didalam Lingkungan Cloud Provider tersebut, Sesuai dengan isi file maka Terraform akan memberitahu resource yang akan dibuat olehnya.Lalu Terraform juga akan memberitahu jika terjadi Kesalahan sintaks, Argumen yang salah, Tipe data yang tidak sesuai, Refrensi Rusak, Masalah Logika Provider.
```bash
student_04_6a1c3bdac312@cloudshell:~ (qwiklabs-gcp-00-7a33fa0d060a)$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_instance.default will be created
  + resource "google_compute_instance" "default" {
      + can_ip_forward       = false
      + cpu_platform         = (known after apply)
      + creation_timestamp   = (known after apply)
      + current_status       = (known after apply)
      + deletion_protection  = false
      + effective_labels     = {
          + "goog-terraform-provisioned" = "true"
        }
      + id                   = (known after apply)
      + instance_id          = (known after apply)
      + label_fingerprint    = (known after apply)
      + machine_type         = "e2-medium"
      + metadata_fingerprint = (known after apply)
      + min_cpu_platform     = (known after apply)
      + name                 = "terraform"
      + project              = "qwiklabs-gcp-00-7a33fa0d060a"
      + self_link            = (known after apply)
      + tags_fingerprint     = (known after apply)
      + terraform_labels     = {
          + "goog-terraform-provisioned" = "true"
        }
      + zone                 = "europe-west1-c"

      + boot_disk {
          + auto_delete                = true
          + device_name                = (known after apply)
          + disk_encryption_key_sha256 = (known after apply)
          + guest_os_features          = (known after apply)
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)

          + initialize_params {
              + architecture           = (known after apply)
              + image                  = "debian-cloud/debian-12"
              + labels                 = (known after apply)
              + provisioned_iops       = (known after apply)
              + provisioned_throughput = (known after apply)
              + resource_policies      = (known after apply)
              + size                   = (known after apply)
              + snapshot               = (known after apply)
              + type                   = (known after apply)
            }
        }

      + network_interface {
          + internal_ipv6_prefix_length = (known after apply)
          + ipv6_access_type            = (known after apply)
          + ipv6_address                = (known after apply)
          + name                        = (known after apply)
          + network                     = "default"
          + network_attachment          = (known after apply)
          + network_ip                  = (known after apply)
          + stack_type                  = (known after apply)
          + subnetwork                  = (known after apply)
          + subnetwork_project          = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


## Basic Terraform Implementasi (File basic-gcp-terraform.tf)
Melakukan Implementasi Konfigurasi dan Mendeploy Infrastructure menggunakan Google Cloud Platform (GCP). 

- Menginialisasi Project
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/google versions matching "3.5.0"...
- Installing hashicorp/google v3.5.0...
- Installed hashicorp/google v3.5.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

- Melakukan penerapan dan Eksekusi menggunakan command terraform apply, Terraform akan langsung mengeksekusi isi file ke penerapan resource langsung di Cloud Provider yang dipilih.
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform apply
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_network.vpc_network will be created
  + resource "google_compute_network" "vpc_network" {
      + auto_create_subnetworks         = true
      + delete_default_routes_on_create = false
      + gateway_ipv4                    = (known after apply)
      + id                              = (known after apply)
      + ipv4_range                      = (known after apply)
      + name                            = "terraform-network"
      + project                         = (known after apply)
      + routing_mode                    = (known after apply)
      + self_link                       = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_compute_network.vpc_network: Creating...
google_compute_network.vpc_network: Still creating... [10s elapsed]
google_compute_network.vpc_network: Still creating... [20s elapsed]
google_compute_network.vpc_network: Creation complete after 27s [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

terraform show digunakan untuk memeriksa dan menampilkan informasi dari state file (terraform.tfstate) file tersebut berisi Daftar resource apa saja yang telah di bangun ke Cloud Provider.Lalu command berikut untuk memeriksa dari file tersebut tentang Infrastructure apa saja yang telah dibangun. 
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform show
# google_compute_network.vpc_network:
resource "google_compute_network" "vpc_network" {
    auto_create_subnetworks         = true
    delete_default_routes_on_create = false
    id                              = "projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network"
    name                            = "terraform-network"
    project                         = "qwiklabs-gcp-00-7f515e8e31bc"
    routing_mode                    = "REGIONAL"
    self_link                       = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network"
}
```

### Create VM Instance after Create VPC
- Menggunakan Terraform mempermudah dalam management resource jika memperbarui sebuah resource dengan menambahkan resource baru, Terraform tidak akan membuat ulang semua resource, Terraform akan langsung menambahkan resource yang baru saja di tambahkan

Melakukan Eksekusi resource ke GCP
```bash
student_04_914270f0ad3d@cloudshell:~$  terraform apply
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_instance.vm_instance will be created
  + resource "google_compute_instance" "vm_instance" {
      + can_ip_forward       = false
      + cpu_platform         = (known after apply)
      + deletion_protection  = false
      + guest_accelerator    = (known after apply)
      + id                   = (known after apply)
      + instance_id          = (known after apply)
      + label_fingerprint    = (known after apply)
      + machine_type         = "e2-micro"
      + metadata_fingerprint = (known after apply)
      + min_cpu_platform     = (known after apply)
      + name                 = "terraform-instance"
      + project              = (known after apply)
      + self_link            = (known after apply)
      + tags_fingerprint     = (known after apply)
      + zone                 = (known after apply)

      + boot_disk {
          + auto_delete                = true
          + device_name                = (known after apply)
          + disk_encryption_key_sha256 = (known after apply)
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)

          + initialize_params {
              + image  = "debian-cloud/debian-12"
              + labels = (known after apply)
              + size   = (known after apply)
              + type   = (known after apply)
            }
        }

      + network_interface {
          + name               = (known after apply)
          + network            = "terraform-network"
          + network_ip         = (known after apply)
          + subnetwork         = (known after apply)
          + subnetwork_project = (known after apply)

          + access_config {
              + nat_ip       = (known after apply)
              + network_tier = (known after apply)
            }
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_compute_instance.vm_instance: Creating...
google_compute_instance.vm_instance: Still creating... [10s elapsed]
google_compute_instance.vm_instance: Still creating... [20s elapsed]
google_compute_instance.vm_instance: Creation complete after 27s [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

- Setelah menambahkan sebuah Tags di Instance maka Terraform hanya akan memperbarui VM Instance yang telah dibuat
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform apply
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]
google_compute_instance.vm_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # google_compute_instance.vm_instance will be updated in-place
  ~ resource "google_compute_instance" "vm_instance" {
        id                   = "projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance"
        name                 = "terraform-instance"
      ~ tags                 = [
          + "dev",
          + "web",
        ]
        # (15 unchanged attributes hidden)

        # (4 unchanged blocks hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_compute_instance.vm_instance: Modifying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]
google_compute_instance.vm_instance: Still modifying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/z...entral1-a/instances/terraform-instance, 10s elapsed]
google_compute_instance.vm_instance: Modifications complete after 17s [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
```

## Destroy Infrastructure Using Terraform

Menghapus semua resource yang telah di terapkan
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform destroy
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]
google_compute_instance.vm_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  - destroy

Terraform will perform the following actions:

  # google_compute_instance.vm_instance will be destroyed
  - resource "google_compute_instance" "vm_instance" {
      - can_ip_forward       = false -> null
      - cpu_platform         = "Intel Broadwell" -> null
      - deletion_protection  = false -> null
      - enable_display       = false -> null
      - guest_accelerator    = [] -> null
      - id                   = "projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance" -> null
      - instance_id          = "7171739679568976008" -> null
      - label_fingerprint    = "42WmSpB8rSM=" -> null
      - labels               = {} -> null
      - machine_type         = "e2-micro" -> null
      - metadata             = {} -> null
      - metadata_fingerprint = "ZxpG__N6TlQ=" -> null
      - name                 = "terraform-instance" -> null
      - project              = "qwiklabs-gcp-00-7f515e8e31bc" -> null
      - self_link            = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance" -> null
      - tags                 = [
          - "dev",
          - "web",
        ] -> null
      - tags_fingerprint     = "XaeQnaHMn9Y=" -> null
      - zone                 = "us-central1-a" -> null

      - boot_disk {
          - auto_delete = true -> null
          - device_name = "persistent-disk-0" -> null
          - mode        = "READ_WRITE" -> null
          - source      = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/disks/terraform-instance" -> null

          - initialize_params {
              - image  = "https://www.googleapis.com/compute/v1/projects/cos-cloud/global/images/cos-stable-121-18867-199-88" -> null
              - labels = {} -> null
              - size   = 10 -> null
              - type   = "pd-standard" -> null
            }
        }

      - network_interface {
          - name               = "nic0" -> null
          - network            = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network" -> null
          - network_ip         = "10.128.0.3" -> null
          - subnetwork         = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/regions/us-central1/subnetworks/terraform-network" -> null
          - subnetwork_project = "qwiklabs-gcp-00-7f515e8e31bc" -> null

          - access_config {
              - nat_ip       = "34.58.227.250" -> null
              - network_tier = "PREMIUM" -> null
            }
        }

      - scheduling {
          - automatic_restart   = true -> null
          - on_host_maintenance = "MIGRATE" -> null
          - preemptible         = false -> null
        }

      - shielded_instance_config {
          - enable_integrity_monitoring = true -> null
          - enable_secure_boot          = false -> null
          - enable_vtpm                 = true -> null
        }
    }

  # google_compute_network.vpc_network will be destroyed
  - resource "google_compute_network" "vpc_network" {
      - auto_create_subnetworks         = true -> null
      - delete_default_routes_on_create = false -> null
      - id                              = "projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network" -> null
      - name                            = "terraform-network" -> null
      - project                         = "qwiklabs-gcp-00-7f515e8e31bc" -> null
      - routing_mode                    = "REGIONAL" -> null
      - self_link                       = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network" -> null
    }

Plan: 0 to add, 0 to change, 2 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

google_compute_instance.vm_instance: Destroying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]
google_compute_instance.vm_instance: Still destroying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/z...entral1-a/instances/terraform-instance, 10s elapsed]
google_compute_instance.vm_instance: Destruction complete after 20s
google_compute_network.vpc_network: Destroying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]
google_compute_network.vpc_network: Still destroying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network, 10s elapsed]
google_compute_network.vpc_network: Still destroying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network, 20s elapsed]
google_compute_network.vpc_network: Still destroying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network, 30s elapsed]
google_compute_network.vpc_network: Still destroying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network, 40s elapsed]
google_compute_network.vpc_network: Destruction complete after 47s

Destroy complete! Resources: 2 destroyed.
```

## Menambahkan Static IP Address (file basic-gcp-terraform)

- Baris kode berikut akan memberikan IP public yang statis(permanen) ke VM instance di GCP
```bash
  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
```

- Melakukan Plan untuk melihat apakan penerapannya nantinya berhasil dan disini muncul EXTERNAL IP dan nama dari ip static yang akan dibuat
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform plan
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]
google_compute_instance.vm_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_address.vm_static_ip will be created
  + resource "google_compute_address" "vm_static_ip" {
      + address            = (known after apply)
      + address_type       = "EXTERNAL"            # Lihat Blok ini
      + creation_timestamp = (known after apply)
      + id                 = (known after apply)
      + name               = "terraform-static-ip" # Lihat blok ini
      + network_tier       = (known after apply)
      + project            = (known after apply)
      + purpose            = (known after apply)
      + region             = (known after apply)
      + self_link          = (known after apply)
      + subnetwork         = (known after apply)
      + users              = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions
if you run "terraform apply" now.
```

- Update Network Interface (basic-gcp-terraform)
```bash
  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
```

- Command ini akan menyimpan hasil rencana terbaru untuk disimpan ke sebuah file bernama (static_ip), Terraform akan memesan 1 IP ekternal statis dari GCP Nilai IP nya akan di ketahui setelah Apply (eksekusi)
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform plan -out static_ip
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]
google_compute_instance.vm_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create
  ~ update in-place

Terraform will perform the following actions:

  # google_compute_address.vm_static_ip will be created
  + resource "google_compute_address" "vm_static_ip" {
      + address            = (known after apply)
      + address_type       = "EXTERNAL"
      + creation_timestamp = (known after apply)
      + id                 = (known after apply)
      + name               = "terraform-static-ip"
      + network_tier       = (known after apply)
      + project            = (known after apply)
      + purpose            = (known after apply)
      + region             = (known after apply)
      + self_link          = (known after apply)
      + subnetwork         = (known after apply)
      + users              = (known after apply)
    }

  # google_compute_instance.vm_instance will be updated in-place
  ~ resource "google_compute_instance" "vm_instance" {
        id                   = "projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance"
        name                 = "terraform-instance"
        tags                 = [
            "dev",
            "web",
        ]
        # (15 unchanged attributes hidden)

      ~ network_interface {
            name               = "nic0"
            # (4 unchanged attributes hidden)

          ~ access_config {
              ~ nat_ip       = "34.55.147.49" -> (known after apply)
                # (1 unchanged attribute hidden)
            }
        }

        # (3 unchanged blocks hidden)
    }

Plan: 1 to add, 1 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: static_ip

To perform exactly these actions, run the following command to apply:
    terraform apply "static_ip"
```

- Terraform akan mengeksekusi isi dari file "static_ip" persis yang disimpan dari terraform plan tadi.
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform apply "static_ip"
google_compute_address.vm_static_ip: Creating...
google_compute_address.vm_static_ip: Creation complete after 4s [id=projects/qwiklabs-gcp-00-7f515e8e31bc/regions/us-central1/addresses/terraform-static-ip]
google_compute_instance.vm_instance: Modifying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]
google_compute_instance.vm_instance: Still modifying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/z...entral1-a/instances/terraform-instance, 10s elapsed]
google_compute_instance.vm_instance: Still modifying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/z...entral1-a/instances/terraform-instance, 20s elapsed]
google_compute_instance.vm_instance: Modifications complete after 28s [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Apply complete! Resources: 1 added, 1 changed, 0 destroyed.
```

## Menambah Bucket ke file (basic-gcp-terraform)

- Membuat simulasi rencana pembuatan Cloud Storage Bucket
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform plan
google_compute_address.vm_static_ip: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/regions/us-central1/addresses/terraform-static-ip]
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]
google_compute_instance.vm_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_instance.another_instance will be created
  + resource "google_compute_instance" "another_instance" {
      + can_ip_forward       = false
      + cpu_platform         = (known after apply)
      + deletion_protection  = false
      + guest_accelerator    = (known after apply)
      + id                   = (known after apply)
      + instance_id          = (known after apply)
      + label_fingerprint    = (known after apply)
      + machine_type         = "e2-micro"
      + metadata_fingerprint = (known after apply)
      + min_cpu_platform     = (known after apply)
      + name                 = "terraform-instance-2"
      + project              = (known after apply)
      + self_link            = (known after apply)
      + tags_fingerprint     = (known after apply)
      + zone                 = (known after apply)

      + boot_disk {
          + auto_delete                = true
          + device_name                = (known after apply)
          + disk_encryption_key_sha256 = (known after apply)
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)

          + initialize_params {
              + image  = "cos-cloud/cos-stable"
              + labels = (known after apply)
              + size   = (known after apply)
              + type   = (known after apply)
            }
        }

      + network_interface {
          + name               = (known after apply)
          + network            = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network"
          + network_ip         = (known after apply)
          + subnetwork         = (known after apply)
          + subnetwork_project = (known after apply)

          + access_config {
              + nat_ip       = (known after apply)
              + network_tier = (known after apply)
            }
        }
    }

  # google_storage_bucket.example_bucket will be created
  + resource "google_storage_bucket" "example_bucket" {
      + bucket_policy_only = (known after apply)
      + force_destroy      = false
      + id                 = (known after apply)
      + location           = "US"
      + name               = "bucket-punya-rouf"
      + project            = (known after apply)
      + self_link          = (known after apply)
      + storage_class      = "STANDARD"
      + url                = (known after apply)

      + website {
          + main_page_suffix = "index.html"
          + not_found_page   = "404.html"
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions
if you run "terraform apply" now.
```

- Mengeksekusi resource Cloud Storage Bucket
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform apply
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]
google_compute_address.vm_static_ip: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/regions/us-central1/addresses/terraform-static-ip]
google_compute_instance.vm_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_instance.another_instance will be created
  + resource "google_compute_instance" "another_instance" {
      + can_ip_forward       = false
      + cpu_platform         = (known after apply)
      + deletion_protection  = false
      + guest_accelerator    = (known after apply)
      + id                   = (known after apply)
      + instance_id          = (known after apply)
      + label_fingerprint    = (known after apply)
      + machine_type         = "e2-micro"
      + metadata_fingerprint = (known after apply)
      + min_cpu_platform     = (known after apply)
      + name                 = "terraform-instance-2"
      + project              = (known after apply)
      + self_link            = (known after apply)
      + tags_fingerprint     = (known after apply)
      + zone                 = (known after apply)

      + boot_disk {
          + auto_delete                = true
          + device_name                = (known after apply)
          + disk_encryption_key_sha256 = (known after apply)
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)

          + initialize_params {
              + image  = "cos-cloud/cos-stable"
              + labels = (known after apply)
              + size   = (known after apply)
              + type   = (known after apply)
            }
        }

      + network_interface {
          + name               = (known after apply)
          + network            = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network"
          + network_ip         = (known after apply)
          + subnetwork         = (known after apply)
          + subnetwork_project = (known after apply)

          + access_config {
              + nat_ip       = (known after apply)
              + network_tier = (known after apply)
            }
        }
    }

  # google_storage_bucket.example_bucket will be created
  + resource "google_storage_bucket" "example_bucket" {
      + bucket_policy_only = (known after apply)
      + force_destroy      = false
      + id                 = (known after apply)
      + location           = "US"
      + name               = "bucket-punya-rouf"
      + project            = (known after apply)
      + self_link          = (known after apply)
      + storage_class      = "STANDARD"
      + url                = (known after apply)

      + website {
          + main_page_suffix = "index.html"
          + not_found_page   = "404.html"
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_storage_bucket.example_bucket: Creating...
google_storage_bucket.example_bucket: Creation complete after 1s [id=bucket-punya-rouf]
google_compute_instance.another_instance: Creating...
google_compute_instance.another_instance: Still creating... [10s elapsed]
google_compute_instance.another_instance: Still creating... [20s elapsed]
google_compute_instance.another_instance: Creation complete after 26s [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance-2]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

- Define a Provisioner
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform apply
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]
google_compute_address.vm_static_ip: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/regions/us-central1/addresses/terraform-static-ip]
google_compute_instance.vm_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_instance.another_instance will be created
  + resource "google_compute_instance" "another_instance" {
      + can_ip_forward       = false
      + cpu_platform         = (known after apply)
      + deletion_protection  = false
      + guest_accelerator    = (known after apply)
      + id                   = (known after apply)
      + instance_id          = (known after apply)
      + label_fingerprint    = (known after apply)
      + machine_type         = "e2-micro"
      + metadata_fingerprint = (known after apply)
      + min_cpu_platform     = (known after apply)
      + name                 = "terraform-instance-2"
      + project              = (known after apply)
      + self_link            = (known after apply)
      + tags_fingerprint     = (known after apply)
      + zone                 = (known after apply)

      + boot_disk {
          + auto_delete                = true
          + device_name                = (known after apply)
          + disk_encryption_key_sha256 = (known after apply)
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)

          + initialize_params {
              + image  = "cos-cloud/cos-stable"
              + labels = (known after apply)
              + size   = (known after apply)
              + type   = (known after apply)
            }
        }

      + network_interface {
          + name               = (known after apply)
          + network            = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network"
          + network_ip         = (known after apply)
          + subnetwork         = (known after apply)
          + subnetwork_project = (known after apply)

          + access_config {
              + nat_ip       = (known after apply)
              + network_tier = (known after apply)
            }
        }
    }

  # google_storage_bucket.example_bucket will be created
  + resource "google_storage_bucket" "example_bucket" {
      + bucket_policy_only = (known after apply)
      + force_destroy      = false
      + id                 = (known after apply)
      + location           = "US"
      + name               = "bucket-punya-rouf"
      + project            = (known after apply)
      + self_link          = (known after apply)
      + storage_class      = "STANDARD"
      + url                = (known after apply)

      + website {
          + main_page_suffix = "index.html"
          + not_found_page   = "404.html"
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_storage_bucket.example_bucket: Creating...
google_storage_bucket.example_bucket: Creation complete after 1s [id=bucket-punya-rouf]
google_compute_instance.another_instance: Creating...
google_compute_instance.another_instance: Still creating... [10s elapsed]
google_compute_instance.another_instance: Still creating... [20s elapsed]
google_compute_instance.another_instance: Creation complete after 26s [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance-2]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
student_04_914270f0ad3d@cloudshell:~$ terraform apply
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]
google_compute_address.vm_static_ip: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/regions/us-central1/addresses/terraform-static-ip]
google_storage_bucket.example_bucket: Refreshing state... [id=bucket-punya-rouf]
google_compute_instance.another_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance-2]
google_compute_instance.vm_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes
are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

- Menggunakan command Terraform taint untuk memberitahu Terraform membuat ulang intancenya, Jadi Terraform taint berguna untuk menandai sebuah resource yang telah dibangun untuk di ganti ulang oleh Terraform
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform taint google_compute_instance.vm_instance
Resource instance google_compute_instance.vm_instance has been marked as tainted.
```

- Setelah menggunakan taint lalu gunakan command Apply untuk menghapus dan membuat ulang Resource
```bash
student_04_914270f0ad3d@cloudshell:~$ terraform apply
google_compute_address.vm_static_ip: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/regions/us-central1/addresses/terraform-static-ip]
google_storage_bucket.example_bucket: Refreshing state... [id=bucket-punya-rouf]
google_compute_network.vpc_network: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/global/networks/terraform-network]
google_compute_instance.another_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance-2]
google_compute_instance.vm_instance: Refreshing state... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # google_compute_instance.vm_instance is tainted, so must be replaced
-/+ resource "google_compute_instance" "vm_instance" {
      ~ cpu_platform         = "Intel Broadwell" -> (known after apply)
      - enable_display       = false -> null
      ~ guest_accelerator    = [] -> (known after apply)
      ~ id                   = "projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance" -> (known after apply)
      ~ instance_id          = "3145150969907009861" -> (known after apply)
      ~ label_fingerprint    = "42WmSpB8rSM=" -> (known after apply)
      - labels               = {} -> null
      - metadata             = {} -> null
      ~ metadata_fingerprint = "ZxpG__N6TlQ=" -> (known after apply)
      + min_cpu_platform     = (known after apply)
        name                 = "terraform-instance"
      ~ project              = "qwiklabs-gcp-00-7f515e8e31bc" -> (known after apply)
      ~ self_link            = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance" -> (known after apply)
        tags                 = [
            "dev",
            "web",
        ]
      ~ tags_fingerprint     = "XaeQnaHMn9Y=" -> (known after apply)
      ~ zone                 = "us-central1-a" -> (known after apply)
        # (3 unchanged attributes hidden)

      ~ boot_disk {
          ~ device_name                = "persistent-disk-0" -> (known after apply)
          + disk_encryption_key_sha256 = (known after apply)
          + kms_key_self_link          = (known after apply)
          ~ source                     = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/disks/terraform-instance" -> (known after apply)
            # (2 unchanged attributes hidden)

          ~ initialize_params {
              ~ image  = "https://www.googleapis.com/compute/v1/projects/cos-cloud/global/images/cos-stable-121-18867-199-88" -> "cos-cloud/cos-stable"
              ~ labels = {} -> (known after apply)
              ~ size   = 10 -> (known after apply)
              ~ type   = "pd-standard" -> (known after apply)
            }
        }

      ~ network_interface {
          ~ name               = "nic0" -> (known after apply)
          ~ network_ip         = "10.128.0.2" -> (known after apply)
          ~ subnetwork         = "https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-7f515e8e31bc/regions/us-central1/subnetworks/terraform-network" -> (known after apply)
          ~ subnetwork_project = "qwiklabs-gcp-00-7f515e8e31bc" -> (known after apply)
            # (1 unchanged attribute hidden)

          ~ access_config {
              ~ network_tier = "PREMIUM" -> (known after apply)
                # (1 unchanged attribute hidden)
            }
        }

      - scheduling {
          - automatic_restart   = true -> null
          - on_host_maintenance = "MIGRATE" -> null
          - preemptible         = false -> null
        }

      - shielded_instance_config {
          - enable_integrity_monitoring = true -> null
          - enable_secure_boot          = false -> null
          - enable_vtpm                 = true -> null
        }
    }

Plan: 1 to add, 0 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_compute_instance.vm_instance: Destroying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]
google_compute_instance.vm_instance: Still destroying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/z...entral1-a/instances/terraform-instance, 10s elapsed]
google_compute_instance.vm_instance: Still destroying... [id=projects/qwiklabs-gcp-00-7f515e8e31bc/z...entral1-a/instances/terraform-instance, 20s elapsed]
google_compute_instance.vm_instance: Destruction complete after 21s
google_compute_instance.vm_instance: Creating...
google_compute_instance.vm_instance: Still creating... [10s elapsed]
google_compute_instance.vm_instance: Still creating... [20s elapsed]
google_compute_instance.vm_instance: Provisioning with 'local-exec'...
google_compute_instance.vm_instance (local-exec): Executing: ["/bin/sh" "-c" "echo terraform-instance:  34.58.227.250 >> ip_address.txt"]
google_compute_instance.vm_instance: Creation complete after 26s [id=projects/qwiklabs-gcp-00-7f515e8e31bc/zones/us-central1-a/instances/terraform-instance]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
```