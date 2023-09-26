Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter2,
           Rails.application.credentials.x[:client_id],
           Rails.application.credentials.x[:client_secret],
           callback_path: ENV['X_CALLBACK_PATH'] || "/auth/twitter2/callback",
           scope: "tweet.read users.read"

  OmniAuth.config.on_failure =
    Proc.new { |env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure }
end