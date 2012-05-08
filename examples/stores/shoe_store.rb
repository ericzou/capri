$: << File.expand_path("../../lib", File.dirname(__FILE__))
require 'sinatra'
require 'shotgun'

require 'capri'
Capri.domain "localhost" do 
  css "style.css"
  
  replace('h1', :with => "Hello I am Shoe Store")

  # for_page "/products" do 
  #   replace('#h1', :with => 'Hey, inside products')
  # end

  # for_page "/product/:id" do 
  # end

  # for_page '/product/*' do 
  # end

  # for_page "/product/search" do 
  #   replace('#h1', :with => "Hey, I searched #{params[q]}")
  # end
end

use Capri::Middleware

get "/" do 
  haml :store
end