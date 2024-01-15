data "aws_cloudwatch_event_source" "buildkite" {
  name_prefix = var.event_source_name
}

data "aws_lambda_function" "to_trigger" {
  function_name = var.function_name
}

resource "aws_cloudwatch_event_bus" "buildkite" {
  name = data.aws_cloudwatch_event_source.buildkite.name
  event_source_name = data.aws_cloudwatch_event_source.buildkite.name
}

resource "aws_cloudwatch_event_target" "buildkite_lambda_trigger" {
  target_id = var.name
  event_bus_name = aws_cloudwatch_event_bus.buildkite.name
  rule      = aws_cloudwatch_event_rule.buildkite.name
  arn       = data.aws_lambda_function.to_trigger.arn
}

resource "aws_cloudwatch_event_rule" "buildkite" {
  name_prefix        = var.name
  description = "Captures Buildkite Events and Sends them to a lambda"
  event_bus_name = aws_cloudwatch_event_bus.buildkite.name

  event_pattern = jsonencode({
    source = [
      {
        prefix = "aws.partner/buildkite.com"
      }
    ]
  })
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.to_trigger.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.buildkite.arn
}
