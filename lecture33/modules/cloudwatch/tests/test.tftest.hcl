variables {
  instance_id = "i-123456789"
}

run "alarm_check" {

  command = plan

  assert {
    condition     = aws_cloudwatch_metric_alarm.cpu_alarm.metric_name == "CPUUtilization"
    error_message = "メトリック名が一致しません"
  }

  assert {
    condition     = aws_cloudwatch_metric_alarm.cpu_alarm.statistic == "Average"
    error_message = "計測対象が平均値ではありません"
  }

  assert {
    condition     = aws_cloudwatch_metric_alarm.cpu_alarm.threshold == 3
    error_message = "アラームの閾値が一致しません"
  }

  assert {
    condition     = aws_cloudwatch_metric_alarm.cpu_alarm.dimensions["InstanceId"] != ""
    error_message = "計測対象のインスタンスが未設定です"
  }

  assert {
    condition     = aws_cloudwatch_metric_alarm.cpu_alarm.datapoints_to_alarm == 2
    error_message = "閾値の計測回数が一致しません"
  }

  assert {
    condition     = aws_cloudwatch_metric_alarm.cpu_alarm.treat_missing_data == "missing"
    error_message = "設定が一致しません"
  }

  assert {
    condition     = contains(aws_cloudwatch_metric_alarm.cpu_alarm.alarm_actions,"arn:aws:sns:ap-northeast-1:302263062504:aws-study")
    error_message = "アラームの通知先が未設定です"
  }
}
