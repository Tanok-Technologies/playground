module "iam" {
  source     = "./modules/iam"
  user_name  = "nana"
  group_name = "demo"
  tags       = { "foo" = "bar" }
}
