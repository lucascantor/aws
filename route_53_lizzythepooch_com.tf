# ------------------------------------------------------------------------------------------
# lizzythepooch.com

resource "aws_route53_record" "lizzythepooch_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    "kiki.bunny.net",
    "coco.bunny.net",
  ]
}
