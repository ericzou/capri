require 'sinatra'
require 'haml'

require 'capri'

use Capri::Middleware

get "/" do 
  "hello, I m shoe store"
  haml :store
end