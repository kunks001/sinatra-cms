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

	get '/pages/new' do
		@page = Page.new
		@title = 'add page'
		haml :new
	end

	get '/pages/:id' do
		@page = Page.find(params[:id])
		@title = @page.title
		haml :show
	end

	post '/pages' do
	  page = Page.create(params[:page])
	  redirect to("/pages/#{page.id}")
	end

end

class Page
  include Mongoid::Document
 
  field :title,   type: String
  field :content, type: String
end