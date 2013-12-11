require 'sinatra'
require 'sinatra/reloader' if development?
require 'mongoid'
require 'haml'
 
configure do
  Mongoid.load!("./mongoid.yml")
end