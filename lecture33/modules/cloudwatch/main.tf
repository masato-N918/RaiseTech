resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "aws-study-ec2-utilization-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 3
  alarm_description   = "EC2使用率が3%以上になりました"
  dimensions = {
    InstanceId = var.instance_id
  }
  datapoints_to_alarm = 2
  treat_missing_data  = "missing"
  alarm_actions       = ["arn:aws:sns:ap-northeast-1:302263062504:aws-study"]
}
