require 'open-uri'
require 'json'

module RSearch

  class Google
    
    def initialize(key, cx)
      @key, @cx = key, cx
    end

    def search(query, options={})
      search = Search.new(@key, @cx, query, options)
      search.do!
    end

    class Search
      
      def initialize(key, cx, q, options={})
        @url = "https://www.googleapis.com/customsearch/v1?key=#{key}&cx=#{cx}&q=#{q.gsub(" ", "+")}"

        options.each do |option, value|
          @url += "&#{option}=#{value}"
        end
      end

      def do!
        response = open(@url).read
        JSON.parse(response)
      end

    end

  end

end
