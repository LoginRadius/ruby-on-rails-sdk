module LoginRadius
  class Response
    # LoginRadius Response Class: Defines the data response object returned from an API call.

    attr_accessor :code, :body

    def initialize(response)
      if response.code == '429'
        too_many_request='{"Message":"Too Many Request in particular time frame","ErrorCode":429,"Description":"Too Many Request in particular time frame"}'
        self.code = response.code
        self.body = JSON.parse(too_many_request, :symbolize_names => true)
      else
        self.code = response.code
        self.body = JSON.parse(response.body, :symbolize_names => true)
      end      
    end
  end
end
