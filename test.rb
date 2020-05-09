class Person
  public
  def call_method_protected
   puts self.my_protected_method
  end

  def call_method_private
    puts self.my_private_method
  end

  def my_public_method
     'I am a public method'
  end

  protected
    def my_protected_method
      'I am a protected method'
    end

  private
    def my_private_method
      'I am a private method'
    end
end

person2 = Person.new

person2.call_method_protected
person2.call_method_private