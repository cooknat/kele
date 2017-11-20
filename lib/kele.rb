require 'httparty'

class Kele
  
  include HTTParty
  attr_accessor  :base_uri, :auth_token, :response
  
 
    
  def initialize(email, password)
    
    @base_uri = "https://www.bloc.io/api/v1"
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {email: email, password: password} )
    
    @auth_token = response["auth_token"]
    
    unless @auth_token
      raise RuntimeError.new("Invalid credentials, please try again.")
    end
      
  end    
  
end    
    