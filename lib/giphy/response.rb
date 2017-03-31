module Giphy
  class Response
    def self.build(response)
      new(response).data
    end

    def initialize(response)
      @response = response
    end

    def data
      raise Giphy::Errors::Unexpected unless response.body
      if response.body['data'].nil?
        raise Giphy::Errors::API.new(error)
      elsif response.body['data'].empty?
        raise Giphy::Errors::EmptyResponse.new
      end
      response.body['data']
    end

    private

    attr_reader :response

    def error
      "#{meta['error_type']} #{meta['error_message']}"
    end

    def meta
      @meta ||= response.body.fetch('meta')
    end
  end
end
