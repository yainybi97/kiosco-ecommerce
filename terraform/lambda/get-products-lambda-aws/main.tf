locals {
  get_products_lambda = GetProducts
}

# Crear el rol IAM para la Lambda
resource "aws_iam_role" "lambda_role" {
  name               = "lambda1-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

# Documento de la política de suceso para el rol de Lambda (que le permite a Lambda ejecutarse)
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals = [
      {
        type        = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    ]
  }
}

# Crear la política de permisos de la Lambda utilizando la plantilla
resource "aws_iam_policy" "lambda_policy" {
  name        = "get_products_policy"
  description = "Lambda policy to allow get_products actions"
  policy      = templatefile("${path.module}/policies/get_products_policy.tpl", {})
}

# Asociar la política al rol
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Crear la función Lambda
resource "aws_lambda_function" "get_products_service" {
  function_name = "${local.get_products_lambda}Service"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda/go/get-productos-lambda-aws/cmd/main.go"  # Cambia esto según el archivo Go y la función handler
  runtime       = "go1.x"
  filename      = "function.zip"  # El archivo .zip que subimos en el paso anterior
  source_code_hash = filebase64sha256("function.zip")  # Calcula el hash del archivo .zip

  environment {
    variables = {
      ENVIRONMENT = "production"
    }
  }
}
