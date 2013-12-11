require 'sinatra'
require 'sinatra/reloader' if development?
require 'mongoid'
require 'haml'
 
configure do
  Mongoid.load!("./mongoid.yml")
end

class Page
  include Mongoid::Document
 
  field :title,   type: String
  field :content, type: String
end