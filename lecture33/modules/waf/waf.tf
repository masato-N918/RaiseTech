variable "alb_arn" {}

resource "aws_wafv2_web_acl" "main_waf" {
  name  = "WebACL"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WAFmetric"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 0

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "CoreRules"
      sampled_requests_enabled   = true
    }
  }
}

resource "aws_wafv2_web_acl_association" "waf_association" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.main_waf.arn
}
