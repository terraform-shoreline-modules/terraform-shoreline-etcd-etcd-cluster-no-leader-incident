resource "shoreline_notebook" "etcd_cluster_no_leader_incident" {
  name       = "etcd_cluster_no_leader_incident"
  data       = file("${path.module}/data/etcd_cluster_no_leader_incident.json")
  depends_on = [shoreline_action.invoke_etcd_health_check,shoreline_action.invoke_etcd_restart]
}

resource "shoreline_file" "etcd_health_check" {
  name             = "etcd_health_check"
  input_file       = "${path.module}/data/etcd_health_check.sh"
  md5              = filemd5("${path.module}/data/etcd_health_check.sh")
  description      = "Check the Etcd cluster for any system failures or network connectivity issues that may have caused the cluster to lose its leader."
  destination_path = "/agent/scripts/etcd_health_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "etcd_restart" {
  name             = "etcd_restart"
  input_file       = "${path.module}/data/etcd_restart.sh"
  md5              = filemd5("${path.module}/data/etcd_restart.sh")
  description      = "Restart the Etcd service on the affected node to allow the system to elect a new leader."
  destination_path = "/agent/scripts/etcd_restart.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_etcd_health_check" {
  name        = "invoke_etcd_health_check"
  description = "Check the Etcd cluster for any system failures or network connectivity issues that may have caused the cluster to lose its leader."
  command     = "`chmod +x /agent/scripts/etcd_health_check.sh && /agent/scripts/etcd_health_check.sh`"
  params      = ["ETCD_CA_FILE","ETCD_CERT_FILE","ETCD_KEY_FILE","ETCD_ENDPOINT"]
  file_deps   = ["etcd_health_check"]
  enabled     = true
  depends_on  = [shoreline_file.etcd_health_check]
}

resource "shoreline_action" "invoke_etcd_restart" {
  name        = "invoke_etcd_restart"
  description = "Restart the Etcd service on the affected node to allow the system to elect a new leader."
  command     = "`chmod +x /agent/scripts/etcd_restart.sh && /agent/scripts/etcd_restart.sh`"
  params      = ["NODE_NAME"]
  file_deps   = ["etcd_restart"]
  enabled     = true
  depends_on  = [shoreline_file.etcd_restart]
}

