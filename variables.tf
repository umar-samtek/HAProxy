variable "s3_bucket" {
  default     = "haproxy-test-bucket"   #Add bucket name here
  description = "Name of the S3 bucket we are creating the proxy for" 
}

variable "s3_bucket_2" {
  default     = "haproxy-test-bucket-2" #Add 2nd bucket name here
  description = "Name of the 2nd S3 bucket we are creating the proxy for"
}


variable "iam_instance_profile" {
  default     = "haproxy" #Update Instance Profile Name -- update to terraform instance profile
  description = "Name of the instance profile assigned to the EC2 instances"
}

variable "name" {
  default     = "haproxy"
  description = "General name for all resources in AWS created with this module"
}

variable "key_name" {
  default     = "haproxy-test-key" #Put key name here
  description = "Name of the EC2 Key to assign to the Instances" 
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Type of EC2 instances to launch with the ASG"
}

variable "root_block_size" {
  default     = "50"
  description = "Size of the root volume in GB"
}

variable "ebs_block_size" {
  default     = "50"
  description = "Size of the data volume in GB"
}

variable "min_size" {
  default     = 1
  description = "Min number of instances in the ASG"
}

variable "max_size" {
  default     = 2
  description = "Max number of instances in the ASG"
}

variable "desired_capacity" {
  default     = 1
  description = "Desired number of instances in the ASG"
}

variable "environment" {
  default     = "dev" #Put Tag Name here
  description = "Name of the environment, used in tags" 
}

variable "vpc_name" {
  description = "Name of the VPC the ha proxy set up will be created in"
  default     = "test-vpc" #Put VPC name here
}

variable "subnet_names" {
  description = "Names of private subnets to launch HA proxy resources and NLB in"
  type        = list
  default     = ["data-subnet-a", "data-subnet-b"] #Put Subnet Names here
}

#FIXME: This assumes two subnets, we need to make this a list, so we can handle more or less than 2
variable "route_table1" {
  description = "Name of the route table associated with the first subnet"
  default     = "data-a" #Add Subnet name here
}

variable "route_table2" {
  description = "Name of the route table associated with the second subnet"
  default     = "data-b" #Add Subnet Name here
}

variable "iam_policy" {
  description = "IAM policy to be associated via HA Proxy Instance Profiles"
  default     = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
        "Effect": "Allow",
        "Action": [
                  "s3:ListBucket",
                  "s3:PutObject",
                  "s3:PutObjectAcl",
                  "s3:GetObject",
                  "s3:GetObjectAcl"
                  ], 
        "Resource": [
          "arn:aws:s3:::haproxy-test-bucket",  
          "arn:aws:s3:::haproxy-test-bucket/*",
          "arn:aws:s3:::haproxy-test-bucket-2",
          "arn:aws:s3:::haproxy-test-bucket-2/*" 
          ]
    }
]
}
EOF
}
#Replace @@@ with name of bucket 
#Added 2nd bucket to resource