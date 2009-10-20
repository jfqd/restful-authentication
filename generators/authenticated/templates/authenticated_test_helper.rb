module AuthenticatedTestHelper
  def log_in
    user = User.make
    @request.session[:<%= file_name %>_id] = <%= file_name %> ? (<%= file_name %>.is_a?(<%= file_name.camelize %>) ? <%= file_name %>.id : <%= table_name %>(<%= file_name %>).id) : nil
  end

  def authorize
    user = User.make
    @request.env["HTTP_AUTHORIZATION"] = <%= file_name %> ? ActionController::HttpAuthentication::Basic.encode_credentials(<%= table_name %>(<%= file_name %>).login, 'testing') : nil
  end
  
end
