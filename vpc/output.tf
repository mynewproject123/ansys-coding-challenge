output "vpc_id" {
  description = "The ID of the VPC"
  value       = modules.vpc.vpc_ansys.id
}