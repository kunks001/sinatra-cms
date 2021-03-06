require 'sinatra'
require 'mongoid'
require 'haml'
 
configure do
  Mongoid.load!("./mongoid.yml")
end

class Server < Sinatra::Base

  set :method_override, true

  get '/pages' do
    @pages = Page.all
    haml :index
  end

  get '/pages/new' do
    @page = Page.new
    @title = 'add page'
    haml :new
  end

  get '/pages/:id/edit' do
    @page = Page.find(params[:id])
    haml :edit
  end

  get '/:permalink' do
    begin
      @page = Page.find_by(permalink: params[:permalink])
      @title = @page.title
    rescue
      pass
    end
    haml :show
  end

  put '/pages/:id' do
    page = Page.find(params[:id])
    page.update_attributes(params[:page])
    redirect to("#{page.permalink}")
  end

  post '/pages' do
    page = Page.create(params[:page])
    redirect to("#{page.permalink}")
  end

  delete '/pages/delete/:id' do
    Page.find(params[:id]).destroy
    redirect to('/pages')
  end

end

class Page
  include Mongoid::Document
 
  field :title,   type: String
  field :content, type: String
  field :permalink, type: String, default: -> { make_permalink }

  def make_permalink
    title.downcase.gsub(' ','-') if title
  end
end