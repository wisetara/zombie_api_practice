  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  def encode(username, password)
    ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  end

#for use with tokens
setup do
  @user = User.create!
end

def token_header(token)
  ActionController::HttpAuthentication::Token.encode_credentials(token)
end
