1.
class Person
  attr_reader :name
  
  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name


# What is output and why? What does this demonstrate about instance variables that differentiates them from local variables?

=begin
The output will be the string object "Bob". On line `11` we are calling the `name` method and the `name` method returns the value of the instance variable `@name`. This tells us that the scope of instance variables are not limited to the lexical scope of the method definition where they are set. Instance variables are accessible anywhere within the object.
=end
2.
module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
p teddy.swim   

remember
# What is output and why? What does this demonstrate about instance variables?
=begin
On line `35` we call the instance method `swim` and the method will return `"swimming"` if the instance variable `@can_swim` is true. However, because `@can_swim` has not been initialized yet its value is `nil`. Therefore, Line `35` will output nil, because the return value of a `if` conditional is `nil` if the code was not executed.
This demonstrates that instance variables must be initialized or their value will be `nil`. 
=end
remember

3. 
module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
  
  def sides
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides 
p Square.new.sides 
p Square.new.describe_shape 


# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above? 

=begin
The output will be 4, 4, and error. The first two `self`'s on line `55` and `56` both point to the calling class object, in this case `Square`. The `self` on line `60` refers to the calling class instance, in this case a new `Square` instance. Since both of these methods are called from either the `Square` class or an instance of `Square` we are able to find the constant `SIDES` initialized in the `Quadrilateral` class definition that is a superclass of `Square`. The `self` on line `48` is will also refer to the calling object instance. 
This example demonstrates that constants are lexically scoped, meaning that when referenced ruby will look for the constant where it is referenced first then move up the scope hierarchy. In this case on line `48` ruby will search for the constant `SIDES` in the `describe_shape` method first, then move up the scope hierarchy to the module scope where the hierarchy ends and since the constant `SIDES` wasn't found, ruby will raise an error. Also, because `Quadrilateral` is a superclass of `Square` and within the lexical hierarchy of `Square` both class method `sides` and instance method `sides` are both able to find the constant `SIDES`. 
=end

4.
class AnimalClass
  attr_accessor :name, :animals
  
  def initialize(name)
    @name = name
    @animals = []
  end
  
  def <<(animal)
    animals << animal
  end
  
  def +(other_class)
    animals + other_class.animals
  end
end

class Animal
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end

mammals = AnimalClass.new('Mammals')
mammals << Animal.new('Human')
mammals << Animal.new('Dog')
mammals << Animal.new('Cat')

birds = AnimalClass.new('Birds')
birds << Animal.new('Eagle')
birds << Animal.new('Blue Jay')
birds << Animal.new('Penguin')

some_animal_classes = mammals + birds

p some_animal_classes 


# What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect the method to return?
=begin
The output will be an array of objects. Based on the code this is what we would expect, but it is not very reader friendly. Would adjust the code in the `+` method to make it only add that name of the animals.
def +(other_class)
  animals.map(&:name) + other_class.animals.map(&:name)
end
This would create a new a array of just the names of the animals and seems to be more inline with what we would want.
=end

5.
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    name = n
    height = h
    weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end


sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs') 
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info 
# => Spartacus weighs 10 lbs and is 12 inches tall.

# We expect the code above to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` Why does our `change_info` method not work as expected?
=begin
This is because on lines `143, 144, 145` new local variables are being initialized, not reassigning the instance variables. To accuretly reference the instance variables `self.` must be prepended to them.
=end

6.
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def change_name
    name = name.upcase
  end
end

bob = Person.new('Bob')
p bob.name 
bob.change_name
p bob.name


# In the code above, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? How could we adjust this code to output `'BOB'`? 
=begin
On line `16` a new local variable is being initialized, not reassigning the instance variable `@name`. To correct `self` needs to be prepended to `name` so the instance variable is referenced.
=end

7.
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels                             

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels                           
p Vehicle.wheels                              

class Car < Vehicle; end

p Vehicle.wheels
p Motorcycle.wheels                           
p Car.wheels     


# What does the code above output, and why? What does this demonstrate about class variables, and why we should avoid using class variables when working with inheritance?
=begin
The code will output 4, 2, 2, 2, 2, 2. This is because class variables are initialized as soon as the class is defined. Hence all referenced to the class variable `@@wheels` after class `Motorcycle` is defined will return 2. This demonstrates that the class variables in subclasses with the same name as class variables in superclasses will reassign the variable so the value stored in the superclass will become inaccessible. This is very dangerous because important data could be lost and needed data could become no longer be accessible. 
=end

8.
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")       
p bruno


# What is output and why? What does this demonstrate about `super`?
=begin
The output will be the bruno object with instance variables `@name` and `color` both set to "brown".
This is because the `super` keyword on line `229` has not been explicitly told not to pass the arguments from the current calling method to the overridden superclass method. In this case the subclass `initialize` method takes only takes `color` as an argument and the `super` takes that argument and passes that into the superclass `initialize` which takes one argument `name`. So we can see that the value of the `color` argument is passed into both `initialize` methods, hence both `@name` and `@color` are both assigned `"brown"`. To change this we must change the parameters in the subclass `initialize` method to `initialize(name, color)`, then explicitly pass in an argument through the `super` keyword `super(name)`.
`super` be default will take all arguments in the current callng method and pass them into the superclass of the same name.
=end

9.
class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super
    @color = color
  end
end

bear = Bear.new("black")        


# What is output and why? What does this demonstrate about `super`? 
=begin
This code will raise an error because the `super` will try to pass in an argument to the superclass `initialize` method which has no parameters, hence the error. This can be corrected by explicitly telling `super` to not pass any arguments to the supclass method buy using parathesis, `super()`. By doing so `super` will not pass in any of the arguments in the current method to the superclass method and ruby will no longer raise an error.

=end

10.
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

module Danceable
  def dance
    "I'm dancing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

module GoodAnimals
  include Climbable

  class GoodDog < Animal
    include Swimmable
    include Danceable
  end
  
  class GoodCat < Animal; end
end

good_dog = GoodAnimals::GoodDog.new
p good_dog.walk


# What is the method lookup path used when invoking `#walk` on `good_dog`?
=begin
The method lookup path will be `GoodAnimals::GoodDog`, `Danceable`, `Swimmable`, `Animal`, `Walkable`, `Object`, `Kernel`, `BasicObject`.

=end


11.
class Animal
  def eat
    puts "I eat."
  end
end

class Fish < Animal
  def eat
    puts "I eat plankton."
  end
end

class Dog < Animal
  def eat
     puts "I eat kibble."
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Dog.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end


# What is output and why? How does this code demonstrate polymorphism? 
=begin
The output will be "I eat", "I eat plankton", "I eat kibble". This demonstrates polymorphism through inheritance and method overriding. The subclasses of `Animal` all have the instance method `eat` which is the same method in the superclass. The method `eat` in the subclasses will override the `eat` method in the superclass. All three class instances will respond to the same method call `eat`. Hence this is polymophism because multiple data types are responding to the same method call.  
=end

12.
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Pet
  def jump
    puts "I'm jumping!"
  end
end

class Cat < Pet; end

class Bulldog < Pet; end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud                     

bob.pets.jump 


# We raise an error in the code above. Why? What do `kitty` and `bud` represent in relation to our `Person` object?  
=begin
The code raises an error because the `jump` method is an instance method of `Pet`, however we are trying to call it on the the array that holds the `Pet` instance objects and not on the objects themselves. Hence we need to iterate through the array and then call `jump` on each object within the array.
`kitty` and `bud` both represent collaborator objects because they are objects in another object's state.
=end


13.
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name   


# What is output and why?
=begin
The output will be `"bark! bark!  bark! bark!"``. This is because the `initialize` method in `Dog` is overridding the `initialize` method in the superclass and therefore the argument value of `name` is not stored in the `@name` instance variable in the superclass. We must use the `super` keyword within the subclass `initialize` method in order for the argument in the subclass method to be passed into the superclass method `initialize` so that it can then be stored in the `@name` instance variable.   
=end

14.
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

al = Person.new('Alexander')
alex = Person.new('Alexander')
p al == alex # => true


# In the code above, we want to compare whether the two objects have the same name. `Line 11` currently returns `false`. How could we return `true` on `line 11`? 

=begin
Currently the `==` method will only compare object equality and therefore we must override it to have the functionality we desire.
def ==(other)
  name == other.name
end
By creating an instance method `==` within the Person class we can now compare the names of two objects using the `==` instance method.
=end

# Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object? How could we prove our case?

=begin
The string objects found in the instanc variables of `@name` for both objects are two unique string objects. We can varify this by calling the `equal?` method,
def name_same?(other)
  name.equal? other.name
end
This will compare the objects and not the values held within. This method would return false if used to compare the two string objects assigned to `@name` in objects `al` and `alex`.

=end

15.
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name.upcase!}."
  end
end

bob = Person.new('Bob')
puts bob.name
puts bob
puts bob.name


# What is output on `lines 14, 15, and 16` and why?
=begin
The output will be `Bob`, `My name is BOB.`, `BOB`. Line `14` will be only capitalized because that is what is originally assigned to `@name`. However, on line 462 the `to_s` method calls the destructive method `upcase!` on the value of `@name`, hence all subsequent references to `@name` will return `BOB`.
=end

 16.
# Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to set an instance variable within the class? Give an example.
=begin
It is generally better to use setter and getter methods when trying to set and retrieve an instance variable rather than reference the instance variable directly. One reason being that setter and getter methods allow us to create general functionality in method definitions that we can use whenever we want to either retrieve or set an instance variable. This could be hiding the raw data (like for SSN's) or formatting the data (like phone #'s to (***) ***-**** ). Getters and setters also allow for more maintainability when those desired functionalities of retrieving and setting instance variables may change in the future. Setter and getter methods play an important role in keeping our code DRY, readable and maintainable.
=end

17.
# Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.

=begin
class PersonanInfo
def initialize(full_name, phone_num, address)
@name = full_name
@phone_num = phone_num
@address = address
end

def phone_num
phone_num = @phone_num.to_s
"(#{phone_num[0..2]}) #{phone_num[3..5]}-#{phone_num[6..9]}"
end

def name
@name.split(' ').map(&:capitalize).join(" ")
end
end

The two instance methods above allow us to get the data we need from the instance variable but in a new format. This allows for more readablility and keeps our code DRY.

=end

18. 
class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end


# What can executing `Triangle.sides` return? What can executing `Triangle.new.sides` return? What does this demonstrate about class variables?

=begin
`Triangle.sides` would return `nil` because the class variable is assigned to `nil` when the class method `sides` is called by the `Triangle` class. After an object of `Triangle` is instantiated the initialized method is called and the class variable `@@sides` is set to 3, hence Triangle.new.sides will return 3.

and `Triangle.new.sides` would return 3. T
=end

19.
# What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.

=begin
`attr_accessor` is a method that takes symbols as an argument and uses them to creates getter and setter methods. `attr_accessor` methods simplifies creating getter and setter methods for instance variables by replacing multiple lines of code that would have been needed to create getter and/or setter methds for each instance variable.

we wouldn't want to use attr_accessor for every instance variable because this could possible lead to unintentional data manipulation. Access to data should be intentional and should otherwise be unaccessible to prevent possible unintentional data changes.

for example:
class Student
  attr_accessor :name
  attr_reader :student_id

  def initialize(name, student_id)
    @name = name
    @student_id = student_id
  end
end

In this example we can get and set `@name` which makes sense because names change. However a students id shouldn't change and therefore no setter method is available for `@student_id`.

    attr_accessor :name, :age, :dob

=end
20.
# What is the difference between states and behaviors?

=begin
The states of an object are what make an object instance unique. They are defined by the values stored in instance variables. Behaviors of an object are its instance methods and they defined in the class of an object instance and are shared among all instances of its class. 
=end

21. 
# What is the difference between instance methods and class methods?

=begin
Instance methods can only be called by the instance of a class and cannot call class methods directly.
Class methods can be called by the class object directly and do not require an instantiated object. Classes cannot call instance methods.
=end

22.
# What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.
=begin
Collaborator objects are objects in another object's state. 
class Owner
  attr_accessro :name, :pets
  def initialize(name)
    @name = name
    @pets = []
  end
end

class Dog
  def initialize(name)
    @name = name
  end
end

joe = Owner.new("Joe")
mac = Dog.new("Mac")
joe.pets << mac

In the above example we have two object instances, `mac`, and `joe`. `mac` is then added to the array object assigned to `joe`'s instance variable `@pets`. This makes `mac` a collaborator object of `joe`. The string object "Joe" and "Mac" are both also collarborator objects of `joe` and `mac` respectively.
=end

23.
# How and why would we implement a fake operator in a custom class? Give an example.
=begin
To implement a fake operator in a custom class we would define a method just like any other:
def >(other)
  age > other.age
end
This now gives the calling object the `>` method that compares ages of the calling object and another object.
We use fake operators in custom classes to implement readable, logical and functional code.  
=end

24.
# What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? Provide examples.
=begin
`Self` in ruby refers to the current calling object. If `self` is in a class method then `self` will refer to the class object. If in the class definition `self` will also refer to the class object. If `self` if in a instance method then it will reference the calling instance object. 

class Person
  puts self # refers to the class object

  def self.class_self # refers to the class object
    puts self # refers to the class object
  end

  def instance_self
    puts self # refers to the object instance 
  end
end

Person.class_self
Person.new.instance_self
=end

25.
class Person
  def initialize(n)
    @name = n
  end
  
  def get_name
    @name
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect # => #<Person:0x000055e79be5dea8 @name="bob">
puts joe.inspect # => #<Person:0x000055e79be5de58 @name="joe">

p bob.get_name # => "bob"


 # What does the above code demonstrate about how instance variables are scoped?
=begin
This example demonstrates that the scope of instance variables are not limited to where they are initialized, but are available to all instance methods defined in the class.
=end

26.
# How do class inheritance and mixing in modules affect instance variable scope? Give an example.
=begin
Instance variables can be mixed in with modules and can be inherited from superclasses. 

module Some_mod
  def initialize
    @name = 'mack'
  end
end

class Person
  attr_reader :name

  def initialize
    @name = "bill"
  end
end

class Child < Person
  include Some_mod

  def find_var
    @name
  end
end

p Child.new.find_var => "mack"

In the example above we can see that when ruby looks for an instance variable it will look for them in mixins before looking for them in a superclass if not found in the current object.
=end

27.
# How does encapsulation relate to the public interface of a class?
=begin
All interfaces of a class other than `initialize`, are public by default. Encapsulation determines what remains public and what becomes private. Instance variables are private by default and must be explicitly made public through setter and getter methods. Ruby uses access control modifiers to implement encapsulation. 
=end

28.
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky


# What is output and why? How could we output a message of our choice instead?
=begin
The output will be the object name and id like such: <GoodDog:0x000055fce06deb78>. This is because the `puts` methos calls `to_s` on the object and the default behavior of `to_s` when called on an object instance is to output its name and object id.
We could change the output of `puts` by defining a custom `to_s` method within the GoodDog class like such:
def to_s
  "My name is #{name} and I'm #{age} years old."
end
=end

# How is the output above different than the output of the code below, and why?

class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky

=begin
The first example uses setter methods to initialize the instance variables but in the second example we are referencing the instance variables directly when we initialize them. Also we are calling the `p` method and not `puts`. `p` will print the name, id and the state of an object, like such: <GoodDog:0x0000558e5fec4d50 @name="Sparky", @age=28>.
=end

29.
# When does accidental method overriding occur, and why? Give an example.
=begin
Accidental method overridding happens when a new method unintentionally has the same name as a method in the classes method lookup path. The overridden method may be a preexisting ruby object method or a custom method.
for example:
class Person
  def send
    some new code
  end
end

`send` is a method in the `Object` class of ruby. In the example above the `Person` class inherits from the superclass `Object` and the new `send` method overrides the `send` method in `Object`.
=end

30.
# How is Method Access Control implemented in Ruby? Provide examples of when we would use public, protected, and private access modifiers.
=begin
Method access control in ruby is implemented by controlling the access to the methods within its classes using the `public`, `private` & `protected` access modifiers. By controlling the access to its methods, we are able to control which interfaces are private and which are public.

All instance methods other than `initialize` are public by default and are accessible to to all public interfaces. We want methods to be public when we need them to be accessible to other public interfaces.

The `pivate` method makes the methods following it private and only accessible with other methods within the current class instance. Interfaces of other instances (including the same class type) cannot access private methods. Instance variables are also private by default and are only veiwable and settable by use of methods. We want to use `private` when we want to prevent the change or veiwing of sensitive data or data that has no use outside the current object instance.

The `protected` method makes the methods following it protected and only accessible with other methods within the current class instance and by other instances of the same class. From within the class `protected` methods act like public methods and from outside the class they act like `private` methds. Hence when other instance objects call protected methods from within the class they do not raise an error. We use `protected` when we want certain data or functionalilty to be accessible by other instances of the same class and to none other.
=end

31.
# Describe the distinction between modules and classes.
=begin
Objects can be instantiated from classes, but cannot be instantiated from modules. Classes can only inherit from one superclass, but modules can be mixed into any number of classes. Modules can be used for namespacing to allow better organization of code and reusability, but classes cannot be used for namespacing.
=end

32.
# What is polymorphism and how can we implement polymorphism in Ruby? Provide examples.
=begin
Polymorphism is when a common interface responds to multiple data types differently.

array = ["string", [1,2,3], { My: "Hash" }]

array.each do |obj|
  p obj.empty?
end

In the example above the array contains 3 different data types, string, array and hash. We then interate over the array and call `empty?` on each different element. The `empty?` method does not care that each element is a different data type as long they each contain the instnace method `empty?`. This is polymorphism in action because multiple data types are interacting with a common interface, `empty?` without raising an error.

=end
33.
# What is encapsulation, and why is it important in Ruby? Give an example.
=begin
Encapsulation allow us to determine what information within an object is accessible outside the object, in other words, what within an object is pulic and what is private. Ruby uses method access controls to inplement encapsulation. Encapsulation is important because it allow us prevent unwanted or unexpected changes to our code through interacting with other public interfaces.

class Car
  attr_reader :make, :model, :year

  def initialize(make, model, year, vin)
    @make = make
    @model = model
    @year = year
    @vin_num = vin
  end

  private
  attr_reader :vin_num
end

In the above example the make, model and year are all public interfaces but the `@vin_num` is made private and unaccessible to external interfaces because it is sensitive data. 

=end

34.
module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

mike = Person.new("Mike")
p mike.walk

kitty = Cat.new("Kitty")
p kitty.walk


# What is returned/output in the code? Why did it make more sense to use a module as a mixin vs. defining a parent class and using class inheritance?
=begin
The output will be "Mike strolls forward" and "Kitty saunters forward". It makes more sense to use a mixin because there is no logical superclass for both `Cat` and `Person` in which to put the `walk` method.

=end
35.
# What is Object Oriented Programming, and why was it created? What are the benefits of OOP, and examples of problems it solves?

=begin
OOP is a programming paradigm that uses classes and objects to organize both data as attributes and procedures as methods. Classes are used as a blueprint to determine the attributes and methods of an object. An object is an instance of its class and it is upon instantiation that the values of its predefined attributes are given values.

OOP uses inheritance to allow parent classes to share methods with child classes, encapsulation to restrict access to certain data and methods, polymorphism to allow different data types to respond to a common interface differently.

Inheritance, encapsulation and polymorphism allows OOP to create and structure code that is more flexible, resuable and maintainable.

OOP was created to help manage large complex software systems. OOP was needed to create large programs that were easier to maintain and alter without having a small change affect the entire code.
=end

36.
# What is the relationship between classes and objects in Ruby?
=begin
Objects contain data about their current state and behavior. Classes provide the templates from which objects are created. An object is an instance of a class. Each object instance of a class is unique even if the objects share the same class.
=end

37.
# When should we use class inheritance vs. interface inheritance?
=begin
We should use class inheritance when multiple classes require a certain behavior and share a common logical superclass. Interface inheritance should be used when mulitple classes require a common behavior but do not share a common logical superclass. 

class inhertiance:
class Pet; end

class Dog < Pet; end
class Cat < Pet; end
class Goldfish < Pet; end

interface inheritance:
module Drivable; end

class Teenager < Drivable; end
class F1Racer < Drivable; end

=end

38.
class Cat
end

whiskers = Cat.new
ginger = Cat.new
paws = Cat.new


# If we use `==` to compare the individual `Cat` objects in the code above, will the return value be `true`? Why or why not? What does this demonstrate about classes and objects in Ruby, as well as the `==` method?
=begin
If the `==` method is used to compare the `Cat` objects above the return value would be false. This is because the `==` method compares two objects and only returns true if both objects point to the same space in memory. This demonstrates that objects instantiated from the same class are all unique objects even though they share the same class. 
=end

39.
class Thing
end

class AnotherThing < Thing
end

class SomethingElse < AnotherThing
end


# Describe the inheritance structure in the code above, and identify all the superclasses.
=begin
`SomethingElse` inherits from `AnothreThing` who inherits from `Thing` who inherits from `Object` who inherits from `Kernel` who inherits from `BasicObject`. `AnotherThing`, `Thing`, `Object`, `Kernel` and `BasicObject` are all superclasses.
=end

40.
module Flight
  def fly; end
end

module Aquatic
  def swim; end
end

module Migratory
  def migrate; end
end

class Animal
end

class Bird < Animal
end

class Penguin < Bird
  include Aquatic
  include Migratory
end

pingu = Penguin.new
pingu.fly


# What is the method lookup path that Ruby will use as a result of the call to the `fly` method? Explain how we can verify this.
=begin
The method lookup path will be`Penguin`, `Migratory`, `Aquatic`, `Bird`, `Animal`, `Object`, `Kernel`, `BasicObject`. We can verify this by calling the `ancestors` method on `Penguin`, like such `Penguin.ancestors`.

=end


41.
class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts sound
  end

  def sound
    "#{@name} says "
  end
end

class Cow < Animal
  def sound
    super + "moooooooooooo!"
  end
end

daisy = Cow.new("Daisy")
daisy.speak


# What does this code output and why?
=begin
This code will return 'Daisy says moooooooooooo!'. This is because the super keyword is used in the `sound` method in the `Cow` class to call the `speak` method in the `Animal` superclass and its return value "Daisy says" is concatenated with the string "moooooooooo!"
=end

42.
class Cat
  def initialize(name, coloring)
    @name = name
    @coloring = coloring
  end

  def purr; end

  def jump; end

  def sleep; end

  def eat; end
end

max = Cat.new("Max", "tabby")
molly = Cat.new("Molly", "gray")


# Do `molly` and `max` have the same states and behaviors in the code above? Explain why or why not, and what this demonstrates about objects in Ruby.
=begin
The object instances `molly` and `max` both have the same behaviors because they are instantiated objects of te same class, but do not have the same state because object instances have unique states.
=end

43.
class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end
  
  def change_grade(new_grade)
    grade = new_grade
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
priya.grade 


# In the above code snippet, we want to return `”A”`. What is actually returned and why? How could we adjust the code to produce the desired result?
=begin
The above code will return `nil` because the `change_grade` method is initializing a new local variable and not reassigning the instance variabel `@grade`. This can be remedied by prepending `self` to `grade` on line `1035`.
=end

44.
class MeMyselfAndI
  self

  def self.me
    self
  end

  def myself
    self
  end
end

i = MeMyselfAndI.new


# What does each `self` refer to in the above code snippet?
=begin
The first, second and thrid `self` all refer to the class object and the fourth `self` will refer to the instance object calling the method `myself`.
=end

45.
class Student
  attr_accessor :grade

  def initialize(name, grade=nil)
    @name = name
  end 
end

ade = Student.new('Adewale')
p ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">


# Running the following code will not produce the output shown on the last line. Why not? What would we need to change, and what does this demonstrate about instance variables?
=begin
Because the `@grade` instance variable has not been initialized yet it will not appear within the object when we call `p` on the object `ade`. To remedy this we must initialize the `@grade` instance variable within the `initialize` method like such,
def initialize(name, grade=nil)
    @name = name
    @grade = grade
  end 
This demonstrates that instance variables must be initialized before they become visible within the object.
=end

46.
class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking."
  end
end

class Knight < Character
  def name
    "Sir " + super
  end
end

sir_gallant = Knight.new("Gallant")
p sir_gallant.name 
p sir_gallant.speak 


# What is output and returned, and why? What would we need to change so that the last line outputs `”Sir Gallant is speaking.”`? 
=begin
The output will be "Sir Gallant" and "Gallant is speaking.". This is because the `speak` method in the `Character` class is referencing the `@name` instance variable directly and not through a getter method, hence the getter method `name` in the `Knight` class is never called to prepend the `"Sir"` to `@name`. This can be remedied by removing the `@` mark from `name` on line `1102`. 
=end

47. 
class FarmAnimal
  def speak
    "#{self} says "
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!"
  end
end

class Lamb < Sheep
  def speak
    super + "baaaaaaa!"
  end
end

class Cow < FarmAnimal
  def speak
    super + "mooooooo!"
  end
end

p Sheep.new.speak
p Lamb.new.speak
p Cow.new.speak 


# What is output and why? 
=begin
The output will be "#<Sheep:0x0000560640c2de30> says baa!", "#<Lamb:0x0000560640c2dc50> says "baa!baaaaaaa!", "#<Cow:0x0000560640c2d9a8> says mooooooo!". The `self` on line `1125` refers to the calling instance object so the object name and id are interpolated into the string. On lines `1131`, `1137` and `1143` the super keyword is used to call the `speak` method in the superclass of the current instance object and concatonate the return value of the superclass method with the string object of the current calling methd. 
=end

48.
class Person
  def initialize(name)
    @name = name
  end
end

class Cat
  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end

sara = Person.new("Sara")
fluffy = Cat.new("Fluffy", sara)


# What are the collaborator objects in the above code snippet, and what makes them collaborator objects?
=begin
`sara` is a collaborator object of `fluffy` and both the string objects "Sara" and "Fluffy" are collaborator object of their respective instance objects. This is because all three of these objects are now part of another object's state. 
=end

49.
number = 42

case number
when 1          then 'first'
when 10, 20, 30 then 'second'
when 40..49     then 'third'
end


# What methods does this `case` statement use to determine which `when` clause is executed?
=begin
The Integer#=== method and the Range#=== methods are used to determine which `when` clause is executed.
=end

50.
class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  @@total_people = 0

  def initialize(name)
    @name = name
  end

  def age
    @age
  end
end

# What are the scopes of each of the different variables in the above code?
=begin
The constant `TITLES`, the class variable `@@total_people` are both scoped to the class object `Person`. Instance objects `@name` and `@age` are both scoped to the object instance of `Person` class. 
=end

51.
# The following is a short description of an application that lets a customer place an order for a meal:

# - A meal always has three meal items: a burger, a side, and drink.
# - For each meal item, the customer must choose an option.
# - The application must compute the total cost of the order.

# 1. Identify the nouns and verbs we need in order to model our classes and methods.
# 2. Create an outline in code (a spike) of the structure of this application.
# 3. Place methods in the appropriate classes to correspond with various verbs.

52. 
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end


# In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix? Which use case would be preferred according to best practices in Ruby, and why?
=begin
We could replace `self` with an `@` mark to reference the instance variabel directly. Hoever, it is considered best practice to always reference instance variabels through setter and getter methods. This is because setter and getter methods allow us easily maintain and alter how our instance variables are viewed and set.
=end

53.
module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive


# What is output and why? What does this demonstrate about how methods need to be defined in modules, and why?
=begin
This code will raise an `NoMethodError` because there is no instance method `drive`. The `drive` method in the module `Drivable` is a module method and is not accessible through object instances even if the module is mixed in. If we remove the `self` from the module method then this code will run as expected. This demonstrated that methods in modules whos names are prepended with a `self` are module methods and those without a `self` are instance methods accessible by object instances.
=end

54.
class House
  attr_reader :price

  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2 # => Home 1 is cheaper
puts "Home 2 is more expensive" if home2 > home1 # => Home 2 is more expensive


# What module/method could we add to the above code snippet to output the desired output on the last 2 lines, and why?
=begin
We could include the `Comparable` module and add a `<=>` method.
class House
  include Comparable

  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end

This will work because the `Comparable` module include the methods for `>` and `<`. The `<=>` method we define will then tell the `Comparable` module what to compare, which in this case is the price of two houses.
=end



SPIKES

### Preschool (by Natalie Thompson)
=begin
*Inside a preschool there are children, teachers, class assistants, a principle, janitors, and cafeteria workers. 
*Both teachers and assistants can help a student with schoolwork and watch them on the playground. 
*A teacher teaches and an assistant helps kids with any bathroom emergencies. 
*Kids themselves can learn and play. 
*A teacher and principle can supervise a class. 
*Only the principle has the ability to expel a kid. 
*Janitors have the ability to clean. 
*Cafeteria workers have the ability to serve food. 
*Children, teachers, class assistants, principles, janitors and cafeteria workers all have the ability to eat lunch.

module Preschool

  module HelpableWatchable
    def help_with_schoolwork
      "help with school work"
    end
    
    def watch_kids_on_playground
      "watching kids play"
    end
  end

  module Supervisable
    def supervise_a_class
      "supervising a class"
    end
  end

  class Person
    def lunch
      "eat lunch"
    end
  end

  class Children < Person
    def learn
      "learning!!"
    end

    def play
      "Playing!!!"
    end
  end

  class Teacher < Person
    include HelpableWatchable
    include Supervisable
    
    def teach
      "teach a class"
    end
  end

  class Assistant < Person
    inculde HelpableWatchable
    
    def help_with_bathroom_emergencies
      "Potty emergency!!"
    end
  end

  Class Principle < Person
    include Supervisable
    
    def expel_a_student 
      "gotta let you go"
    end
  end
  
  class Janitor < Person
    def clean
      "Cleaning"
    end
  end

  class CafeteriaWorker < Person
    def serve_food
      "serving lunch"
    end
  end

end
=end




# Problem by Natalie Thompson
class Person
  def initialize(name, job)
      @name = name
  end 

end

roger = Person.new("Roger", "Carpenter")
puts roger

# Add 1 line of code for the person class
# and 1 line of code in the initalize method. 

#Other than that don't change Person.

# Output:
# "My name is Roger and I am a Carpenter"

# ================================================================

# Problem received from Raul Romero
class Human 
    attr_reader :name

  def initialize(name="Dylan")
    @name = name
  end
  
end

puts Human.new("Jo").hair_colour("blonde")  
# Should output "Hi, my name is Jo and I have blonde hair."

puts Human.hair_colour("")              
# Should "Hi, my name is Dylan and I have blonde hair."

# ================================================================

class Human  # Problem received from Raul Romero
  attr_reader :name 
  
  def initialize(name)
  end
 
end

gilles = Human.new("gilles") 
anna = Human.new("gilles") 

puts anna.equal?(gilles) #should output true # 
puts anna + gilles # should output annagilles 

# ================================================================

#describe what the code below outputs and why from Joseph Ochoa

module Attackable
  def attack
    "attacks!"
  end
end

class Characters
  attr_accessor :name, :characters 
  
  def initialize(name) 
    #
    self.name 
    @characters = [] 
  end
  
  def display
    name
  end
  
  protected 
  attr_reader :name
  attr_writer :name
end

class Monster < Characters
  include Attackable
  
  def initialize(name)
    super
  end
end

class Barbarian < Characters
  def ==(other)
    if(super.self == super.self) # 
      super.self == super.self
    end
  end
end

conan = Barbarian.new('barb') 
rob = Monster.new('monst')
conan.characters << rob
p conan.display

# ================================================================

# From Joseph Ochoa
# give class Barbarian the functionality of the Monster instance attack method:
  # If you used class inheritance, now try doing it without class inheritance directly.
  # If you used modules, now try not using modules
  # If you used duck typing, now don't use duck typing 

class Monster
  def attack
    "attacks!"
  end
end

class Barbarian
  
end
    
# ================================================================

# Without adding any methods below, implement a solution; originally by Natalie Thompson, 
# this version by Oscar Cortes
class ClassA 
  attr_reader :field1, :field2
  
  def initialize(num)
    @field1 = "xyz"
    @field2 = num
  end
end

class ClassB 
  attr_reader :field1

  def initialize
    @field1 = "abc"
  end
end

obj1 = ClassA.new(50)
obj2 = ClassA.new(25)
obj3 = ClassB.new

p obj1 > obj2
p obj2 > obj3

# ========================================================================
# Unknown
class BenjaminButton 
  
  def initialize
  end
  
  def get_older
  end
  
  def look_younger
  end
  
  def die
  end
end

class BenjaminButton
end

benjamin = BenjaminButton.new
p benjamin.actual_age # => 0
p benjamin.appearance_age # => 100

benjamin.actual_age = 1
p benjamin.actual_age

benjamin.get_older
p benjamin.actual_age # => 2
p benjamin.appearance_age # => 99

benjamin.die
p benjamin.actual_age # => 100
p benjamin.appearance_age # => 0

# ========================================================================

# Originally by Natalie Thompson, this version by James Wilson
class Wizard
  attr_reader :name, :hitpoints
  
  def initialize(name, hitpoints)
    @name = name
    @hitpoints = hitpoints
  end  
  
  def fireball
    "casts Fireball for 500 damage!"
  end
  
end

class Summoner < Wizard
  attr_reader :souls
  
  def initialize(name, hitpoints)
    # only add one line here
    @souls = []
  end
  
  def soul_steal(character)
    @souls << character
  end
end

gandolf = Summoner.new("Gandolf", 100)
p gandolf.name # => "Gandolf"

valdimar = Wizard.new("Valdimar", 200)
p valdimar.fireball #=> "casts fireball for 500 damage!"

p gandolf.hitpoints #=> 100

p gandolf.soul_steal(valdimar) #=> [#<Wizard:0x000055d782470810 @name="Valdimar", @hitpoints=200>]

p gandolf.souls[0].fireball #=> "casts fireball for 500 damage!"

# ========================================================================

# LS Man...legend says LS Man first appeared in SPOT.
module Flightable
  def fly
  end
end

class Superhero    
  attr_accessor :ability
  
  def self.fight_crime
  end
  
  def initialize(name)
    @name = name
  end
  
  def announce_ability
    puts "I fight crime with my #{ability} ability!"
  end
end

class LSMan < Superhero; end

class Ability
  attr_reader :description

  def initialize(description)
    @description = description
  end
end

superman = Superhero.new('Superman')

p superman.fly # => I am Superman, I am a superhero, and I can fly!

LSMan.fight_crime 
# => I am LSMan!
# => I fight crime with my coding skills ability!
# ========================================================================
****
```