require 'open-uri'
require 'json'

module RSearch

  class Google
    
    def initialize(key, cx)
      @key, @cx = key, cx
    end

    def search(query, options={})
      search = Search.new(@key, @cx, query, options)
      search.do
    end

    class Search
      def initialize(key, cx, q, options={})
        @url = "https://www.googleapis.com/customsearch/v1?key=#{key}&cx=#{cx}&q=#{q.gsub(" ", "+")}"

        options.each do |option, value|
          @url += "&#{option}=#{value}"
        end
      end

      def do
        response = open(@url).read
        Response.new(JSON.parse(response))
      end
    end
    
    #endof Search
    class Response
      @@attributes = [:kind, :url, :queries, :context, :items]
      @@attributes.each { |a| attr_accessor a }
      
      def initialize(json_response)
        @@attributes.each do |a|
          instance_variable_set "@#{a}", json_response[a.to_s]
          URL.new(@url)
        end
      end

      class URL
	@@attributes = [:type, :template]
        @@attributes.each { |a| attr_accessor a }
        
        def initialize(json_url)
          @@attributes.each do |a|
            instance_variable_set "@#{a}", json_url[a.to_s]
          end
        end
      end
      #endof URL

    end
    #endof Response
  end
  #endof Google
end
