class User
  attr_accessor :name, :email

  def initialize(attributes = {})
    @name = attributes[:name]
    @email = attributes[:email]
  end

  def name
    @name
  end

  def name=(value)
    puts "call a setter: #{value}"
    @name=value
  end

  def callname=(value)
    puts "call a setter<callname>: #{value}"
    @name=value
  end

  def  formatted_email
    "#{@name} <#{@email}>"
  end
end

user = User.new({name: "John", email: "dove@example.com"})
puts user.formatted_email
user.name = "Will"
user.callname = "Will Next"
puts user.formatted_email
