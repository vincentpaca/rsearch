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
      @@attributes = [:url, :queries, :context, :items]
      @@attributes.each { |a| attr_accessor a }

      def initialize(json_response)
        @@attributes.each do |a|
          
          response = json_response[a.to_s]
          classified_attr = a.to_s.capitalize

          if response.class.to_s == "Hash"
            instance_variable_set "@#{a}", Response.const_get(classified_attr).new(response)
          else
            item_arr = []
            response.each { |r| item_arr << Response.const_get(classified_attr).new(r) }
            instance_variable_set "@#{a}", item_arr
          end
        end
      end

      class Url
        @@url_attributes = [:type, :template]
        @@url_attributes.each { |a| attr_accessor a }
        
        def initialize(json_url)
          @@url_attributes.each { |a| instance_variable_set "@#{a}", json_url[a.to_s] }
        end
      end
      #endof Url
      
      class Queries
        @@queries_attributes = [:nextPage, :request]
        @@queries_attributes.each { |a| attr_accessor a }

        def initialize(json_url)
          @@queries_attributes.each { |a| instance_variable_set "@#{a}", json_url[a.to_s] }
        end
      end
      #endof Queries

      class Context
        @@context_attributes = [:title]
        @@context_attributes.each { |a| attr_accessor a }

        def initialize(json_url)
          @@context_attributes.each { |a| instance_variable_set "@#{a}", json_url[a.to_s] }
        end
      end
      #endof Context

      class Items
        @@items_attributes = [:kind, :title, :htmlTitle, :link, :displayLink, :snippet, :htmlSnippet]
        @@items_attributes.each { |a| attr_accessor a }

        def initialize(json_url)
          @@items_attributes.each { |a| instance_variable_set "@#{a}", json_url }
        end
      end
      #endof Items

    end
    #endof Response
  end
  #endof Google
end
