#--------------------------------------------------------------
# Cluster
#--------------------------------------------------------------

cluster_location = "us-east1"
cluster_name     = "kubernetes-cluster"

#--------------------------------------------------------------
# Cluster Node Admin
#--------------------------------------------------------------

cluster_node_admin_count          = 1
cluster_node_admin_machine_type   = "n1-standard-1"
cluster_node_admin_name           = "admin"
cluster_node_admin_max_node_count = 3
cluster_node_admin_min_node_count = 1

#--------------------------------------------------------------
# Cluster Node Default
#--------------------------------------------------------------

cluster_node_default_count          = 0
cluster_node_default_machine_type   = "n1-standard-1"
cluster_node_default_name           = "default"
cluster_node_default_max_node_count = 3
cluster_node_default_min_node_count = 0