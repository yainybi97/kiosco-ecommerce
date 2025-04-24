terraform {
  source = "../../terraform/lambda/get-products-lambda-aws"  # Ruta al directorio donde se encuentra main.tf
}

# Configuración de variables específicas para esta Lambda (si es necesario)
inputs = {
  lambda_function_name = "get-products"  # Nombre de la Lambda
  aws_region           = "us-east-1"           # Región de AWS
}
