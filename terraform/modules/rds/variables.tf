variable "db_instance_identifier" {
  description = "The name of the database instance."
  type        = string
}

variable "db_engine" {
  description = "The database engine to use."
  type        = string
}

variable "db_engine_version" {
  description = "The version of the database engine to use."
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
}

variable "db_allocated_storage" {
  description = "The allocated storage in gigabytes."
  type        = number
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
}

variable "db_username" {
  description = "The username for the database."
  type        = string
}

variable "rds_sg_id" {
  description = "A list of security group IDs to associate with the RDS instance."
  type        = list(string)
}

variable "db_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ."
  type        = bool
}

variable "vpc_private_subnet_ids" {
  description = "A list of private subnet IDs for the RDS instance."
  type        = list(string)
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
  type        = bool
}

