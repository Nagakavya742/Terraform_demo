
# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach basic execution policy
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Function
resource "aws_lambda_function" "demo" {
  function_name = "scheduled-lambda"

  filename         = "lambda_function.zip"
  source_code_hash = filebase64sha256("lambda_function.zip")

#etag is used to track the changes and the changes are tracked by etag
  handler = "lambda_function.lambda_handler"   #path to ur packaged code
  runtime = "python3.12"
  timeout = 900
  memory_size = 128

  role = aws_iam_role.lambda_role.arn
}

# EventBridge Rule (schedule)
resource "aws_cloudwatch_event_rule" "every_five_minutes" {
  name                = "every-five-minutes"
  schedule_expression = "rate(5 minutes)"
}

#add the lambda target
resource "aws_cloudwatch_event_target" "name" {
  rule = aws_cloudwatch_event_rule.every_five_minutes.name
  target_id = "lambda"
  arn = aws_lambda_function.demo.arn
}


# Connect EventBridge to Lambda
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.every_five_minutes.name
  target_id = "lambda"
  arn       = aws_lambda_function.demo.arn
}

# Permission for EventBridge
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.demo.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_five_minutes.arn
}