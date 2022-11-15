# to create public hosted zone only
resource "aws_route53_zone" "primary_domain" {
  name = "krishnausa.com"
}

# Tp create public hosted zone and subdomain zone for that 
resource "aws_route53_zone" "second_domain" {
  name = "kk-usa.com"
}

resource "aws_route53_zone" "dev" {
  name = "dev.kk-usa.com"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.second_domain.zone_id
  name    = "dev.kk-usa.com"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.dev.name_servers
}

# To crate A record for kk-usa.com zone 
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.second_domain.zone_id
  name    = "www.kk-usa.com"
  type    = "A"
  ttl     = 300
  records = [10.0.0.100]
}
# To crate CNAME for above A record WWW
resource "aws_route53_record" "www_CNAME" {
  zone_id = aws_route53_zone.second_domain.zone_id
  name    = "kk-usa-new.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_route53_record.www.name]
}

