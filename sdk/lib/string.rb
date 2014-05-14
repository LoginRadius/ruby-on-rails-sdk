class String
  def lr_underscore #lr_ appended so no method naming conflicts with other gems
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1 \2').
    gsub(/([a-z\d])([A-Z])/,'\1 \2').
    downcase
  end
end