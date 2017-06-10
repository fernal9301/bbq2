class ApplicationMailer < ActionMailer::Base
  # обратный адрес всех писем по умолчанию
  default from: "lesson58gp@gmail.com"

  # Задаем макет для всех писем
  layout 'mailer'
end
