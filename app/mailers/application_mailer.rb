# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@ibank.by'
  layout 'mailer'
end
