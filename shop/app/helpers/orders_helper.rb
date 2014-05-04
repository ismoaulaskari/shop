module OrdersHelper
require 'net/smtp'

def send_emailorder(to,opts={})
  opts[:server]      ||= 'localhost'
  opts[:from]        ||= 'youraccount@yourserver' #sending might be denied if this is not real
  opts[:from_alias]  ||= 'youraccount@yourserver'
  opts[:subject]     ||= "Shop testing message"
  opts[:body]        ||= "Sent from shop application"

  msg = <<END_OF_MESSAGE
From: #{opts[:from_alias]} <#{opts[:from]}>
To: <#{to}>
Subject: #{opts[:subject]}

#{opts[:body]}
END_OF_MESSAGE

  Net::SMTP.start(opts[:server]) do |smtp|
    smtp.send_message msg, opts[:from], to
  end
end

end
