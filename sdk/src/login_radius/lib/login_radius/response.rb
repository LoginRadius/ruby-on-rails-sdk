module LoginRadius
  class Response
    # LoginRadius Response Class: Defines the data response object returned from an API call.

    attr_accessor :code, :body

    def initialize(response)
      self.code = response.code
      self.body = JSON.parse(response.body, :symbolize_names => true)
    end
  end
end
