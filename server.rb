require 'sinatra'
require 'mongoid'
require 'haml'
 
configure do
  Mongoid.load!("./mongoid.yml")
end

class Server < Sinatra::Base
end

class Page
  include Mongoid::Document
 
  field :title,   type: String
  field :content, type: String
end