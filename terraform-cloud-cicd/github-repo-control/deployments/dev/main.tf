//--------------------------------------------------------------------
// Variables



//--------------------------------------------------------------------
// Modules
module "compute" {
  source  = "app.terraform.io/mattschulman/compute/aws"
  version = "1.0.1"

  aws_region          = "us-east-1"
  public_key_material = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDxE1ZyC8jgJyNA/b92tqeIV01xvT0N6cyn/nVtMjYCaxdVtGbQ40RHK7hvsJunWCURgEnTZ5BISYSrGaBU7iLYY4LdfM2XelFshiu30aCTg4/KtHjg2CyF/TDz97UfPO0h+TZQ9ZFFO84GyacMifvfLqGOZF/rb6SeDG8h4oAv+4CU6gLOWyJl/0km6XFhg5+tC9mpwdEfsjkRUVrcXqWOJ0vxZ5xUODOZIsJHhB02C+gfjqRvgSwzn+DOBV4n9MmeumwQznaNUDv2JCKF5jxtR7qSLr9CwX9kZ0g/l5tIQu0iyN7abcZ+g2RxzajmT1lSYdwD5CMxrDFccJmvYuN9lT+HhG046Au8NJRi2N5p7OBnYTRVFTU5PZ4IkALuh5ZloZHdmrZ9ptT4BI3AQsqfBhVpkHQw2maEavl8IEelwx8Spx2dJAANYaF5OGDeutBKmqSsIrvkFhwYH5p88cihY2tI21QaB0uyEg8Hpe4d3KMMJvOXmDEvfpACHu0BFRM= matt@MacBookAir.home"
  public_sg           = module.networking.public_sg
  public_subnets      = module.networking.public_subnets
}

module "networking" {
  source  = "app.terraform.io/mattschulman/networking/aws"
  version = "1.0.0"

  access_ip  = "0.0.0.0/0"
  aws_region = "us-east-1"
}