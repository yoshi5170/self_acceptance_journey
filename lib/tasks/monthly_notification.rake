namespace :monthly_notification do
  desc '月の初めにLINE通知を送る'
  task send_monthly_notification: :environment do
    if Date.today.day == 1
      month = Date.today.month
      MonthlyTheme.send_monthly_notification(month)
    else
      Rails.logger.info('Not the first day of the month, no notification sent.')
    end
  end
end
