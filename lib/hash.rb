class Hash
  def self.lr_convert_hash_keys(value) #lr_ appended so no method naming conflicts with other gems
    case value
      when Array
        value.map { |v| lr_convert_hash_keys(v) }
        # or `value.map(&method(:convert_hash_keys))`
      when Hash
        Hash[value.map { |k, v| [k.to_s.lr_underscore, lr_convert_hash_keys(v)] }]
      else
        value
     end
  end
  
  def symbolize_keys!
    transform_keys!{ |key| key.to_sym rescue key }
  end

  def transform_keys!
    keys.each do |key|
      self[yield(key)] = delete(key)
    end
    self
  end
  
end