resource "aws_route53_zone" "primary_domain" {
  name = "krishnausa.com"
}

resource "aws_route53_zone" "main" {
  name = "krishnausa.com"
}

resource "aws_route53_zone" "dev" {
  name = "dev.krishnausa.com"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dev.krishnausa.com"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.dev.name_servers
}
