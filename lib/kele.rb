require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  
  include HTTParty
  include JSON
  include Roadmap
  
  attr_accessor  :base_uri, :auth_token
    
  def initialize(email, password)
    
    @base_uri = "https://www.bloc.io/api/v1"
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {email: email, password: password} )
    @auth_token = response["auth_token"]
    
    unless @auth_token
      raise RuntimeError.new("Invalid credentials, please try again.")
    end
  end    
  
  def get_me
    response = JSON.parse(self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token }).body)
  end  
  
  def get_mentor_availability(id)
    response = JSON.parse(self.class.get("https://www.bloc.io/api/v1/mentors/#{id}/student_availability", headers: { "authorization" => @auth_token }).body)
    response.select { |slot| slot["booked"] == nil }
  end  
  
  def get_messages(page = nil)
       if page
         response = self.class.get('https://www.bloc.io/api/v1/message_threads',
           headers: { "authorization" => @auth_token },
           body: { page: page })
       else
         response = self.class.get('https://www.bloc.io/api/v1/message_threads',
           headers: { "authorization" => @auth_token })
       end
     JSON.parse(response.body)
   end
  
  def create_message(sender, recipient_id, subject, text)
    response = self.class.post("https://www.bloc.io/api/v1/messages", 
        headers: { "authorization" => @auth_token },
        body: {
          "sender": sender,
          "recipient_id": recipient_id,
          "subject": subject,
          "stripped-text": text
        })
        response.success? 
        p "message created"
        p response
  end  
end    
    