class ApplicationMailer < ActionMailer::Base
  include DisplayNameAssigner

  default from: proc { default_sender_address.format }
  layout 'mailer'
end
