variables {
  alb_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:123456789012:loadbalancer/app/test-alb/1234567890abcdef"
}

run "web_acl_check" {

  command = plan

  assert {
    condition     = aws_wafv2_web_acl.main.scope == "REGIONAL"
    error_message = "スコープがリージョンではありません"
  }

  assert {
    condition     = aws_wafv2_web_acl.main.visibility_config[0].metric_name == "WAFmetric"
    error_message = "メトリック名が一致しません"
  }

  assert {
    condition = length([
      for r in aws_wafv2_web_acl.main.rule : r
      if r.name == "AWS-AWSManagedRulesCommonRuleSet"
    ]) > 0
    error_message = "ルール名が一致しません"
  }

  assert {
    condition = length([
      for r in aws_wafv2_web_acl.main.rule : r
      if r.statement[0].managed_rule_group_statement[0].name == "AWSManagedRulesCommonRuleSet"
    ]) > 0
    error_message = "ルールグループ名が一致しません"
  }
}

run "acl_association_check" {

  command = plan

  assert {
    condition     = aws_wafv2_web_acl_association.main_association.resource_arn == "arn:aws:elasticloadbalancing:ap-northeast-1:123456789012:loadbalancer/app/test-alb/1234567890abcdef"
    error_message = "ALBとの関連付けが正しくありません"
  }
}

run "log_group_check" {

  command = plan

  assert {
    condition     = aws_cloudwatch_log_group.waf_log_group.name == "aws-waf-logs-aws-study"
    error_message = "ロググループ名が一致しません"
  }
}
