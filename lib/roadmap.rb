require 'httparty'
require 'json'

module Roadmap
  include HTTParty
    
  def get_roadmap(roadmap_id)
    response = JSON.parse(self.class.get("https://www.bloc.io/api/v1/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token }).body)
  end 
  
  def get_checkpoint(checkpoint_id)
    response = JSON.parse(self.class.get("https://www.bloc.io/api/v1/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token }).body)
  end  
    
end    
    