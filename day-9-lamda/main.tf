resource "aws_iam_role" "lambda_role"{
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "name" {
  role = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "my_lambda" {
   function_name = "my_lambda_function"
   handler = "lambda_function.lambda_function"
   runtime = "python3.8"
   timeout = 900
   role = aws_iam_role.lambda_role.arn   #here we give arn not id because we are calling arn of iam role

   filename = "lambda_function.zip"  #ensure this file exist in directory
  source_code_hash = filebase64sha256("lambda_function.zip")    #it detects every change occured in zip file without this terraform will not detect and runs old code only

    #without source_code_hash , terraform might not detect when the code in the zip file changed

    #this hash is a checkout that triggers a deployment
    #lambda trigger should be given based on event trigger or schedule trigger
}