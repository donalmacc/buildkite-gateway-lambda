variable "name" {
  description = "Descriptive name for the module, used to identify the resources"
}

variable "event_source_name" {
  description = "Event Source name from the Buildkite console"
}

variable "function_name" {
  description = "Name of the lambda to trigger"
}