module Test
  extend ActiveSupport::Concern
  Person = Struct.new(:name, :age) do
    def get_user_info
      User.find_by_name_and_age(@name, @age)
    end
  end
end
