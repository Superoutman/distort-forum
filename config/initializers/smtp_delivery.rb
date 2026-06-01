# typed: false

if Rails.env.production? && ENV["SMTP_HOST"].present?
  ActionMailer::Base.delivery_method = :smtp
end
