variable "create" {
  description = "Determines whether to create EKS managed node group or not"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "platform" {
  description = "[DEPRECATED - use `ami_type` instead. Will be removed in `v21.0`] Identifies the OS platform as `bottlerocket`, `linux` (AL2), `al2023`, or `windows`"
  type        = string
  default     = "linux"
}

################################################################################
# User Data
################################################################################

variable "enable_bootstrap_user_data" {
  description = "Determines whether the bootstrap configurations are populated within the user data template. Only valid when using a custom AMI via `ami_id`"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "Name of associated EKS cluster"
  type        = string
  default     = null
}

variable "cluster_endpoint" {
  description = "Endpoint of associated EKS cluster"
  type        = string
  default     = ""
}

variable "cluster_auth_base64" {
  description = "Base64 encoded CA of associated EKS cluster"
  type        = string
  default     = ""
}

variable "cluster_service_cidr" {
  description = "The CIDR block (IPv4 or IPv6) used by the cluster to assign Kubernetes service IP addresses. This is derived from the cluster itself"
  type        = string
  default     = ""
}

# TODO - remove at next breaking change
variable "cluster_service_ipv4_cidr" {
  description = "[Deprecated] The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks"
  type        = string
  default     = null
}

variable "pre_bootstrap_user_data" {
  description = "User data that is injected into the user data script ahead of the EKS bootstrap script. Not used when `ami_type` = `BOTTLEROCKET_*`"
  type        = string
  default     = ""
}

variable "post_bootstrap_user_data" {
  description = "User data that is appended to the user data script after of the EKS bootstrap script. Not used when `ami_type` = `BOTTLEROCKET_*`"
  type        = string
  default     = ""
}

variable "bootstrap_extra_args" {
  description = "Additional arguments passed to the bootstrap script. When `ami_type` = `BOTTLEROCKET_*`; these are additional [settings](https://github.com/bottlerocket-os/bottlerocket#settings) that are provided to the Bottlerocket user data"
  type        = string
  default     = ""
}

variable "user_data_template_path" {
  description = "Path to a local, custom user data template file to use when rendering user data"
  type        = string
  default     = ""
}

variable "cloudinit_pre_nodeadm" {
  description = "Array of cloud-init document parts that are created before the nodeadm document part"
  type = list(object({
    content      = string
    content_type = optional(string)
    filename     = optional(string)
    merge_type   = optional(string)
  }))
  default = []
}

variable "cloudinit_post_nodeadm" {
  description = "Array of cloud-init document parts that are created after the nodeadm document part"
  type = list(object({
    content      = string
    content_type = optional(string)
    filename     = optional(string)
    merge_type   = optional(string)
  }))
  default = []
}

################################################################################
# Launch template
################################################################################

variable "create_launch_template" {
  description = "Determines whether to create a launch template or not. If set to `false`, EKS will use its own default launch template"
  type        = bool
  default     = true
}

variable "use_custom_launch_template" {
  description = "Determines whether to use a custom launch template or not. If set to `false`, EKS will use its own default launch template"
  type        = bool
  default     = true
}

variable "launch_template_id" {
  description = "The ID of an existing launch template to use. Required when `create_launch_template` = `false` and `use_custom_launch_template` = `true`"
  type        = string
  default     = ""
}

variable "launch_template_name" {
  description = "Name of launch template to be created"
  type        = string
  default     = null
}

variable "launch_template_use_name_prefix" {
  description = "Determines whether to use `launch_template_name` as is or create a unique name beginning with the `launch_template_name` as the prefix"
  type        = bool
  default     = true
}

variable "launch_template_description" {
  description = "Description of the launch template"
  type        = string
  default     = null
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance(s) will be EBS-optimized"
  type        = bool
  default     = null
}

variable "ami_id" {
  description = "The AMI from which to launch the instance. If not supplied, EKS will use its own default image"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The key name that should be used for the instance(s)"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate"
  type        = list(string)
  default     = []
}

variable "cluster_primary_security_group_id" {
  description = "The ID of the EKS cluster primary security group to associate with the instance(s). This is the security group that is automatically created by the EKS service"
  type        = string
  default     = null
}

variable "launch_template_default_version" {
  description = "Default version of the launch template"
  type        = string
  default     = null
}

variable "update_launch_template_default_version" {
  description = "Whether to update the launch templates default version on each update. Conflicts with `launch_template_default_version`"
  type        = bool
  default     = true
}

variable "disable_api_termination" {
  description = "If true, enables EC2 instance termination protection"
  type        = bool
  default     = null
}

variable "kernel_id" {
  description = "The kernel ID"
  type        = string
  default     = null
}

variable "ram_disk_id" {
  description = "The ID of the ram disk"
  type        = string
  default     = null
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type        = any
  default     = {}
}

variable "capacity_reservation_specification" {
  description = "Targeting for EC2 capacity reservations"
  type        = any
  default     = {}
}

variable "cpu_options" {
  description = "The CPU options for the instance"
  type        = map(string)
  default     = {}
}

variable "credit_specification" {
  description = "Customize the credit specification of the instance"
  type        = map(string)
  default     = {}
}

variable "enclave_options" {
  description = "Enable Nitro Enclaves on launched instances"
  type        = map(string)
  default     = {}
}

variable "instance_market_options" {
  description = "The market (purchasing) option for the instance"
  type        = any
  default     = {}
}

variable "maintenance_options" {
  description = "The maintenance options for the instance"
  type        = any
  default     = {}
}

variable "license_specifications" {
  description = "A map of license specifications to associate with"
  type        = any
  default     = {}
}

variable "metadata_options" {
  description = "Customize the metadata options for the instance"
  type        = map(string)
  default = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }
}

# TODO - make this false by default at next breaking change
variable "enable_monitoring" {
  description = "Enables/disables detailed monitoring"
  type        = bool
  default     = true
}

variable "enable_efa_support" {
  description = "Determines whether to enable Elastic Fabric Adapter (EFA) support"
  type        = bool
  default     = false
}

# TODO - make this true by default at next breaking change (remove variable, only pass indices)
variable "enable_efa_only" {
  description = "Determines whether to enable EFA (`false`, default) or EFA and EFA-only (`true`) network interfaces. Note: requires vpc-cni version `v1.18.4` or later"
  type        = bool
  default     = false
}

variable "efa_indices" {
  description = "The indices of the network interfaces that should be EFA-enabled. Only valid when `enable_efa_support` = `true`"
  type        = list(number)
  default     = [0]
}

variable "network_interfaces" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(any)
  default     = []
}

variable "placement" {
  description = "The placement of the instance"
  type        = map(string)
  default     = {}
}

variable "create_placement_group" {
  description = "Determines whether a placement group is created & used by the node group"
  type        = bool
  default     = false
}

# TODO - remove at next breaking change
variable "placement_group_strategy" {
  description = "The placement group strategy"
  type        = string
  default     = "cluster"
}

variable "private_dns_name_options" {
  description = "The options for the instance hostname. The default values are inherited from the subnet"
  type        = map(string)
  default     = {}
}

variable "launch_template_tags" {
  description = "A map of additional tags to add to the tag_specifications of launch template created"
  type        = map(string)
  default     = {}
}

variable "tag_specifications" {
  description = "The tags to apply to the resources during launch"
  type        = list(string)
  default     = ["instance", "volume", "network-interface"]
}

################################################################################
# EKS Managed Node Group
################################################################################

variable "subnet_ids" {
  description = "Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: `kubernetes.io/cluster/CLUSTER_NAME`"
  type        = list(string)
  default     = null
}

variable "placement_group_az" {
  description = "Availability zone where placement group is created (ex. `eu-west-1c`)"
  type        = string
  default     = null
}

variable "min_size" {
  description = "Minimum number of instances/nodes"
  type        = number
  default     = 0
}

variable "max_size" {
  description = "Maximum number of instances/nodes"
  type        = number
  default     = 3
}

variable "desired_size" {
  description = "Desired number of instances/nodes"
  type        = number
  default     = 1
}

variable "name" {
  description = "Name of the EKS managed node group"
  type        = string
  default     = ""
}

variable "use_name_prefix" {
  description = "Determines whether to use `name` as is or create a unique name beginning with the `name` as the prefix"
  type        = bool
  default     = true
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. See the [AWS documentation](https://docs.aws.amazon.com/eks/latest/APIReference/API_Nodegroup.html#AmazonEKS-Type-Nodegroup-amiType) for valid values"
  type        = string
  default     = null
}

variable "ami_release_version" {
  description = "The AMI version. Defaults to latest AMI release version for the given Kubernetes version and AMI type"
  type        = string
  default     = null
}

variable "use_latest_ami_release_version" {
  description = "Determines whether to use the latest AMI release version for the given `ami_type` (except for `CUSTOM`). Note: `ami_type` and `cluster_version` must be supplied in order to enable this feature"
  type        = bool
  default     = false
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT`"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size" {
  description = "Disk size in GiB for nodes. Defaults to `20`. Only valid when `use_custom_launch_template` = `false`"
  type        = number
  default     = null
}

variable "force_update_version" {
  description = "Force version update if existing pods are unable to be drained due to a pod disruption budget issue"
  type        = bool
  default     = null
}

variable "instance_types" {
  description = "Set of instance types associated with the EKS Node Group. Defaults to `[\"t3.medium\"]`"
  type        = list(string)
  default     = null
}

variable "labels" {
  description = "Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed"
  type        = map(string)
  default     = null
}

variable "cluster_version" {
  description = "Kubernetes version. Defaults to EKS Cluster Kubernetes version"
  type        = string
  default     = null
}

variable "launch_template_version" {
  description = "Launch template version number. The default is `$Default`"
  type        = string
  default     = null
}

variable "remote_access" {
  description = "Configuration block with remote access settings. Only valid when `use_custom_launch_template` = `false`"
  type        = any
  default     = {}
}

variable "taints" {
  description = "The Kubernetes taints to be applied to the nodes in the node group. Maximum of 50 taints per node group"
  type        = any
  default     = {}
}

variable "update_config" {
  description = "Configuration block of settings for max unavailable resources during node group updates"
  type        = map(string)
  default = {
    max_unavailable_percentage = 33
  }
}

variable "node_repair_config" {
  description = "The node auto repair configuration for the node group"
  type = object({
    enabled = optional(bool, true)
  })
  default = null
}

variable "timeouts" {
  description = "Create, update, and delete timeout configurations for the node group"
  type        = map(string)
  default     = {}
}

################################################################################
# IAM Role
################################################################################

variable "create_iam_role" {
  description = "Determines whether an IAM role is created or to use an existing IAM role"
  type        = bool
  default     = true
}

variable "cluster_ip_family" {
  description = "The IP family used to assign Kubernetes pod and service addresses. Valid values are `ipv4` (default) and `ipv6`"
  type        = string
  default     = "ipv4"
}

variable "iam_role_arn" {
  description = "Existing IAM role ARN for the node group. Required if `create_iam_role` is set to `false`"
  type        = string
  default     = null
}

variable "iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "iam_role_use_name_prefix" {
  description = "Determines whether the IAM role name (`iam_role_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = null
}

variable "iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "iam_role_attach_cni_policy" {
  description = "Whether to attach the `AmazonEKS_CNI_Policy`/`AmazonEKS_CNI_IPv6_Policy` IAM policy to the IAM IAM role. WARNING: If set `false` the permissions must be assigned to the `aws-node` DaemonSet pods via another method or nodes will not be able to join the cluster"
  type        = bool
  default     = true
}

variable "iam_role_additional_policies" {
  description = "Additional policies to be added to the IAM role"
  type        = map(string)
  default     = {}
}

variable "iam_role_tags" {
  description = "A map of additional tags to add to the IAM role created"
  type        = map(string)
  default     = {}
}

################################################################################
# IAM Role Policy
################################################################################

variable "create_iam_role_policy" {
  description = "Determines whether an IAM role policy is created or not"
  type        = bool
  default     = true
}

variable "iam_role_policy_statements" {
  description = "A list of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) - used for adding specific IAM permissions as needed"
  type        = any
  default     = []
}

################################################################################
# Autoscaling Group Schedule
################################################################################

variable "create_schedule" {
  description = "Determines whether to create autoscaling group schedule or not"
  type        = bool
  default     = true
}

variable "schedules" {
  description = "Map of autoscaling group schedule to create"
  type        = map(any)
  default     = {}
}
