require 'sinatra'
require 'mongoid'
require 'haml'
 
configure do
  Mongoid.load!("./mongoid.yml")
end

class Server < Sinatra::Base

	get '/pages' do
	  @pages = Page.all
	  haml :index
	end

end

class Page
  include Mongoid::Document
 
  field :title,   type: String
  field :content, type: String
end