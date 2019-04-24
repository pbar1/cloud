terragrunt = {
  remote_state {
    backend = "gcs"

    config {
      bucket = "tf-state-390820"
      prefix = "github.com/pbar1/cloud/${path_relative_to_include()}"
    }
  }
}
