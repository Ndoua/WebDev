Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['604741870456387'], ENV['22f5c7b4600df420e8dade1c888fec10']
end