# frozen_string_literal: true

require 'dotenv'
Dotenv.load

#:nodoc:
class Email
  def self.send(from, to, subject, html, _text)
    from = SendGrid::Email.new(email: from)
    to = SendGrid::Email.new(email: to)
    content = SendGrid::Content.new(type: 'text/html', value: html)
    mail = SendGrid::Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
