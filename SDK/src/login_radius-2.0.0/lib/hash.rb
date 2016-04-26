class Hash
  def self.lr_convert_hash_keys(value) #lr_ appended so no method naming conflicts with other gems
    case value
      when Array
        value.map { |v| lr_convert_hash_keys(v) }
      when Hash
        Hash[value.map { |k, v| [k.to_s.lr_underscore, lr_convert_hash_keys(v)] }]
      else
        value
     end
  end
end