# Buildkite-Gateway-Lambda
Triggers an AWS lambda using the Buildkite EventBridge integration. https://buildkite.com/docs/integrations/amazon-eventbridge#events

# How-to
1) Create a new EventBridge rule by going to `https://buildkite.com/organizations/~/services/aws_event_bridge/new`
2) Use the ` Partner Event Source Name` as the `event_source_name` 