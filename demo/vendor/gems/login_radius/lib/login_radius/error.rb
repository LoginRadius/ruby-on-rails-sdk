module LoginRadius
  class Error < StandardError
    def initialize(msg = "An error occurred.")
      super(msg)
    end
  end
end
