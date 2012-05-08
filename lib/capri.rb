# require 'nokogiri'
require 'ruby-debug'
require 'nokogiri'

module Capri
  class << self
    attr_accessor :processors
    def domain(name, &blk)
      @processors ||={}
      processor = @processors[name] ||= Processor.new(name)
      processor.process_blk = blk
    end
  end # self

  class Processor
    attr_accessor :process_blk

    def process(header, response)
      response = Response.new(header, response)      
      response.instance_eval(&process_blk)
      response.to_html
    end
  end # processor

  module Dsl
    def css(path)
      if css_link = find_css_link
        css_link.attribute("href", path)
      end
    end

    def replace(locator, options)
      replacement = options.delete(:with)
      if (node_set = find_elements(locator)) && !node_set.empty?
        node_set.each { |e| e.inner_html = replacement }
      end
    end

    def for_page(path, &blk)
      if path_match?
        instance_eval(&blk)
      end
    end

    private
    
    def find_css_link
      doc.css('link[@data-capri=true]')
    end

    def find_elements(locator)
      doc.css(locator)
    end

    def path_match?(path)
      return true #if @path == path
    end
  end # dsl

  class Response
    include Dsl

    attr_accessor :response, :doc

    def initialize(header, response)
      @response = response
      # @body = @response.body
      @doc = Nokogiri::HTML(@response)
      # @path = @header.path
    end

    def to_html
      @doc.to_html
    end

  end

  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      require 'awesome_print'
      @remote_host = env["REMOTE_HOST"]
      @status, @header, @response = @app.call(env)
      processor = Capri.processors[@remote_host]
      response = processor.process(@header, @response.first) if processor
      puts "===== response #{response}"
        ap :repsonse => @response, :new => [response]
      [@status, @header, [response]]
    end
  end
end