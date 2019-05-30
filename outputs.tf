output "creator_arn" {
  description = "The arn of the lambda function that perfoms alarm creation"
  value       = "${module.creator.arn}"
}
