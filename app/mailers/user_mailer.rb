class UserMailer < Devise::Mailer
  include DisplayNameAssigner

  default from: proc { default_sender_address.format }
end
