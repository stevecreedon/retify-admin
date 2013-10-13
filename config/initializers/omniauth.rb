Rails.application.config.middleware.use OmniAuth::Builder do
  provider :password, :user_model => Identity
  provider :google_oauth2, '974193977054.apps.googleusercontent.com', 'fQgpZ3O1IrN8QLerv0fz8Hfa',{
             :scope => "userinfo.email,userinfo.profile,plus.me,http://gdata.youtube.com,https://www.googleapis.com/auth/analytics.readonly",
             :approval_prompt => "auto"
           }
end

OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure do |env|
  exception = env['omniauth.error']
  error_type = env['omniauth.error.type']
  strategy = env['omniauth.error.strategy']
 
  Rails.logger.error("OmniAuth Error (#{error_type}): #{exception.inspect}")
 
  new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{error_type}"
 
  [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
end
