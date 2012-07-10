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

      @@attributes.each do |a|
        class_name = a.to_s.capitalize
        klass = Object.const_set(class_name, Class.new)

        case class_name
        when "Url"
          instance_vars = ['type', 'template']
        when "Queries"
          instance_vars = ['nextPage', 'request']
        when "Context"
          instance_vars = ['title']
        when "Items"
          instance_vars = ['kind', 'title', 'htmlTitle', 'link', 'displayLink', 'snippet', 'htmlSnippet']
        end

        klass.class_eval do
          attr_accessor *instance_vars

          define_method(:initialize) do |json_url|
            instance_vars.each { |n| instance_variable_set "@#{n}", json_url[n.to_s] }
          end
        end

      end

    end
    #endof Response
  end
  #endof Google
end
