Rails.application.config.middleware.use OmniAuth::Builder do
  provider :password, :user_model => Identity
end

OmniAuth.config.on_failure do |env|
  exception = env['omniauth.error']
  error_type = env['omniauth.error.type']
  strategy = env['omniauth.error.strategy']
 
  Rails.logger.error("OmniAuth Error (#{error_type}): #{exception.inspect}")
 
  new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{error_type}"
 
  [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
end
