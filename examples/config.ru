$: << File.expand_path("../lib", File.dirname(__FILE__))  
require 'capri'

Capri.domain "style.example.com" do 
  css "style.css"
  
  replace('#h1').with('style test')

  for_page "/products" do 
    replace('#h1').with('style test')    
  end

  for_page "/product/:id" do 
  end
end
Capri.register :style do 2
  domain "style.example.com"
  css "style.css"
  replace('#h1').with('style test')
end

Capri.register :shoes do 
  domain "shoes.example.com"
  css "shoes.css"
  replace('#h1').with('shoes test')
end

@application = Proc.new{ [200, { 'Content-Type' => 'text/html'}, "<h1>Test</h1>"]}

use Capri::Core
run @applicaion



