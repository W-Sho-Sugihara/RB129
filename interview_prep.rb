First part

- Will be given a number of concepts to explain and have to code out an example to demonstrate

Second part

- Given a series of coding questions
    - Without running the code, what will this output and why?
    - What will the error in this code be and how can you fix it?
    - Make this code output the expected value, but you can only change [change criteria]
    - Is this possible, why or why not?

# Using examples show how encapsulation works on the state of an object.
    
class Cat
  def initialize(name, type)
    @name = name
    @type = type
  end
end

cat1 = Cat.new("felix", "tabby")
puts @name # unaccessible due to encapsulation.

#===================================================================================================
#===================================================================================================
# before

module Definable
  def what_am_i
    #code here
  end
end

class Bird
  include Definable
  
  def initialize
    #code here
  end
end

class Penguin < Bird
end

class Hawk < Bird
end

penny = Penguin.new
hawky = Hawk.new

penny.what_am_i
hawky.what_am_i
# Initialize an object from the hawk class and an object from the penguin class
# call the what_am_i method on both instances.
# The hawk instance should output: "I am a Bird and I can fly"
# The Penguin instance should output: "I am a Bird and I can't fly"

# In the string that is output "Bird" should be interpolated.
# You are allowed to modify the initialize method and the what_am_i method but that is it.
# The only place you can add code is within these two methods, no attr_* methods allowed.


#********************************************
# after

module Definable
  def what_am_i
    "I am a #{self.class.superclass} and I #{@flyable} fly."
  end
end

class Bird
  include Definable
  
  def initialize(flyable:)
    @flyable = flyable
  end
end

class Penguin < Bird
end

class Hawk < Bird
end

penny = Penguin.new
hawky = Hawk.new

p penny.what_am_i
p hawky.what_am_i


#===================================================================================================
#===================================================================================================

# before

class Person
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def intro
    #code
  end
end

class Steve < Person
  def introduce_mate
    #code
  end  
end

class Dave < Person
end

steve = Steve.new("Steve")

p steve.introduce_mate
# create and instance from the Steve class and call the introduce_mate method on it.

# Output should be:
# Hi, I'm Steve. This is Dave.
# Hi, I'm Dave. Steve's best mate.

# You can change the following methods and nothing else: intro and introduce_mate
# All of the names in the output should be interpolated.

# ==============================================================================
# ==============================================================================
# before

class Zoo
  def initialize
    @animals = []
  end
end

class Primate  
  def initialize(name)
    @name = name
  end
end

class Lemar < Primate
end

class Chimp < Primate
end

zoo = Zoo.new

charlie = Lemar.new("Charlie")
titan = Chimp.new("Titan")

charlie.friend = titan
titan.friend = charlie
zoo << charlie
zoo << titan

puts zoo.animals

=begin
Output should be:
"My name is Charlie and I'm a Chimp. My friend is Titan."
"My name is Titan and I'm a Lemar. My friend is Charlie."

Existing code should not be altered, but add needed methods to produce the output.
=end
# ================================================================================
# ================================================================================

class Library
  def initialize
    @books = []
  end

end

class Book
  attr_reader :title, :author
  
  def initialize(title, author)
    @author = author
    @title = title
  end
end

class LibraryCard
  attr_reader :books_checked_out

  def initialize
    @card_id = rand(1000..9999)
    @books_checked_out = []
  end
end

library = Library.new
lib_card = LibraryCard.new

harry_potter = Book.new("Harry Potter", 'JK Rowling')
lord_of_the_rings = Book.new("Lord of the Rings", 'JRR Tolkien')
dune = Book.new("Dune", 'Frank Herbert')

library << harry_potter << lord_of_the_rings << dune

library.check_out('dune', lib_card)

puts library #=> Harry Potter by JK Rowling, Lord of the Rings by JRR Tolkien
puts lib_card #=> Dune by Frank Herbert



#*************************************
# after

class Library
  def initialize
    @books = []
  end

  def check_out(title, card)
    card.check_out_book(find_book_by_title(title))
    @books.delete(find_book_by_title(title))
  end
  
  def find_book_by_title(title)
    @books.select { |book| book.title.downcase == title.downcase }.first
  end

  def <<(book)
    @books << book
  end

  def to_s
    puts @books
  end
end

class Book
  attr_reader :title, :author
  
  def initialize(title, author)
    @author = author
    @title = title
  end

  def to_s
    "#{@title} by #{@author}"
  end
end

class LibraryCard
  attr_reader :books_checked_out

  def initialize
    @card_id = rand(1000..9999)
    @books_checked_out = []
  end

  def check_out_book(book)
    books_checked_out << book
  end

  def to_s
    puts books_checked_out
  end
end

library = Library.new
lib_card = LibraryCard.new

harry_potter = Book.new("Harry Potter", 'JK Rowling')
lord_of_the_rings = Book.new("Lord of the Rings", 'JRR Tolkien')
dune = Book.new("Dune", 'Frank Herbert')

library << harry_potter << lord_of_the_rings << dune

library.check_out('Dune', lib_card)

puts library #=> Harry Potter by JK Rowling, Lord of the Rings by JRR Tolkien
puts lib_card #=> Dune by Frank Herbert


# =============================================

module Calculatable
  def calculate
    puts "Calculating"
  end
end

class Droid

  def initialize(tag)
    @tag = tag
  end
end

class AstroTechDroid< Droid

end

class ProtocolDroid< Droid

end

r2d2 = AstroTechDroid.new('R2D2')
c3p0 = ProtocolDroid.new('C3P0')

p r2d2.calculate #=> 'Calculating'
p r2d2.zap(c3p0) #=> 'R2D2 zaps C3P0'
p c3p0.speak #=> 'I speak six million languges'
p r2d2.speak #=> Error

# Get the last to four lines output the expected code(last line should raises a NoMethodError). 
# Don't define any new methods inside any of the classes/modules that are already defined. 

# ***************
# note answer

module Calculatable
  def calculate
    puts "Calculating"
  end
end

module Zappable
  
  def zap(other)
    "#{tag} zaps #{other.tag}"
  end
end

module Tagable
  def tag
    @tag
  end
end

module Speakable
  def speak
    "I Speak six million languages"
  end
end

class Droid
  include Calculatable
  include Tagable
  
  def initialize(tag)
    @tag = tag
  end
end

class AstroTechDroid< Droid
  include Zappable
end

class ProtocolDroid< Droid
  include Speakable
 
end

r2d2 = AstroTechDroid.new('R2D2')
c3p0 = ProtocolDroid.new('C3P0')

# ====================================================
# ====================================================

module Math
  def self.multiply(n1, n2)
    n1 * n2
  end
end

class Nums
  def initialize(num1, num2)
    Math.multiply(num1, num2)
  end
end

one = Nums.new(2, 2) #=> 4

two = Nums.new(4, 4) #=> 16

three = Nums.new(223, 459) #=>  102,357



#fill out the necessary peices of the Nums class and create a container method that would be necessary to multiply #the two numbers passed into the Nums objects together. 
#DO NOT USE INTERFACE INHERITANCE 

# ====================================================
# ====================================================
# note solution 

class Vehicle
  attr_reader :make, :model, :color
  
  def initialize(make, model, color, year)
    @make = make
    @model = model
    self.color = color
    @year = year
  end
  
  def ==(other)
    [make, model, year] == [other.make, other.model, other.year]
  end
  
  def >(other)
    year > other.year
  end
  
  private
  
  attr_reader :year
end

class Car < Vehicle; end

camry1 = Car.new('toyota', 'camry', 'silver', 2008)
camry2 = Car.new('toyota', 'camry', 'blue', 2010)

p camry1 == camry2
p camry2 > camry1

# ====================================================
# ====================================================

=begin
What is OOP and why is it important?
What is encapsulation?
Example:
class Person
  def initialize(name, age, ssn)
    @name = name
    @age = age
    @ssn = ssn
  end

  private

  aatr_reader :ssn

  def ssn
    @ssn
  end

end

How does encapsulation relate to the public interface of a class?
What is an object?

What is a class?
What is instantiation?

Person.new

What is polymorphism?

Example:

arr = ["string", [1,2,3], {'hi' => 'bye'}]

arr.each { |e| puts e.empty? }


Explain two different ways to implement polymorphism.
Example:

class Person
  def move
    "walk"
  end
end

class Child < Person
  def move
    "crawl"
  end
end

class F1Racer
  def drive
    "Driving a racecar"
  end
end

class Teenager
  def drive
    "Driving a sedan"
  end
and

[F1Racer.new, Teenager.new].each {|e| puts e.drive } 

How does polymorphism work in relation to the public interface?
What is duck typing? How does it relate to polymorphism - what problem does it solve?
What is inheritance?
Example:
class Person; end
class Child < Person; end

module Methods
  def some_method
  end
end

class Person
  include Methods
end

What is the difference between a superclass and a subclass?
What is a module?
What is a mixin?
When is it good to use class inheritance?
Example:
class Pets; end

class Dogs < Pets; end
class Cats < Pets; end

module Drivable
  def drive
    "Driving"
  end
end

class F1Racer
  include Drivable
end
class Teenager
  include Drivable
end

In inheritance, when would it be good to override a method?
Example:

class Person
  def move
    "walk"
  end
end

class Baby < Person
  def move
    "crawl"
  end
end

What is the method lookup path?
class Person
  include Drivable
end

Person.new ==

When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?

How do you initialize a new object?
What is a constructor method?

Example:

class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
end


What is an instance variable, and how is it related to an object?
What is an instance method?
**How do objects encapsulate state?

Example:

class Person
  def initalize(name) 
    @name = name
  end
end

puts @name

What is the difference between classes and objects?
**How can we expose information about the state of the object using instance methods?

Example:

class Person
  attr_reader :name

  def initalize(name) 
    @name = name
  end

  def name
    @name
  end
end

**What is a collaborator object, and what is the purpose of using collaborator objects in OOP?

Example

class Person
  def initialize(name, pet)
    @name = name
    @pet = pet
  end
end

class Pet
  def initalize(name, type)
    @name = name
    @type = type
  end
end

momo = Pet.new('momo', cat)
joe = Person.new('joe', momo)

**What is an accessor method?

**What is a getter method?

**What is a setter method?
***What is attr_accessor?
**How do you decide whether to reference an instance variable or a getter method?

  Example:
  class Person
    def initialize(name)
      @name = name
    end

    def some_method
      @nam.capitalize
    end
  end
  

# =========
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
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

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      
# => Sparky weighs 10 lbs and is 12 inches tall.

# Why does the .change_info method not work as expected here?

# When would you call a method with self?
Example:

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def change_name(new_name)
    name = new_name # will init a local variable and not call the setter method of @name
  end

  def change_name(new_name)
    self.name = new_name # `self` is used to tell ruby that we are calling a method and not initing a local variable.
  end
end

What are class methods?
Example:

class Person
  def self.method
    "class method"
  end
end

What is the purpose of a class variable?
Example:

class Student
  @@total = 0

  def initalize(name)
    @name = name
    @@total += 1
  end

  def self.total
    @@total
  end
end

Student.new('joe')
Student.total # => 1

What is a constant variable?
Example:

class Person
  SPECIES = 'homo sapien'
end

Person::SPECIES #=> 'homo sapien'

What is the default to_s method that comes with Ruby, and how do you override this?
Example:

class Person
  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{@name}"
  end
end

puts Person.new('Joe')

What are some important attributes of the to_s method?

It is called automatically on the object passed into the puts method and on objects in string interpolation.

From within a class, when an instance method uses self, what does it reference?
What happens when you use self inside a class but outside of an instance method?
Why do you need to use self when calling private setter methods? 
Why use self, and how does self change depending on the scope it is used in?
What is inheritance, and why do we use it?
Give an example of how to use class inheritance.
Example:

class Person
  def initalize(name)
    @name = name
  end
end

class Child < Person; end

joe = Child.new('joe')
p joe 

Give an example of overriding. When would you use it?
Example:

class Person
  def move
    "walk"
  end
end

class Baby < Person
  def move
    "crawl"
  end
end


Give an example of using the super method. When would we use it?
Example:

class Person
  def initialize(name)
    @name = name
  end
end

class Child < Person
  def initialize(name, age)
    super(name)
    @age = age
  end
end


Give an example of using the super method with an argument.
When creating a hierarchical structure, under what circumstance would a module be useful?
Example:

module Drivable
  def drive
    "Driving!!"
  end
end

class Human; end

class F1Racer < Human
  include Drivable
end

class Teenager < Human
  include Drivable
end


What is interface inheritance, and under what circumstance would it be useful in comparison to class inheritance?
How is the method lookup path affected by module mixins and class inheritance?
What is namespacing?
Example:

module Dog
  class Baby; end
end

module Cat
  class Baby; end
end

Cat::Baby.new
Dog::Baby.new

How does Ruby provide the functionality of multiple inheritance?
Describe the use of modules as containers.
Example:

module Car
  class Camry; end
end

module Sedan
  class Camry; end
end

p Car::Camry.new
p Sedan::Camry.new

Why should a class have as few public methods as possible?
What is the private method call used for?
Example:

class Person
  def initialize(name, ssn)
    @name = name 
    @ssn = ssn
  end

  private

  attr_reader :ssn

end

What is the protected keyword used for?
Example:

class Person
  attr_reader :name

  def initialize(name, age)
    @name = name
    @age = age
  end

  def compare_age(other)
    age > other.age
  end

  protected

  attr_reader :age

end

Person.new('joe', 20).compare_age(Person.new('mike', 21)) # => 


What are two rules of protected methods?
note:
They act like public methods within the class definition
They act like private methods outside the class definition


Why is it generally a bad idea to override methods from the Object class, and which method is commonly overridden?
Example:

class Person


What is the relationship between a class and an object?
Explain the idea that a class groups behaviors.
Objects do not share state between other objects, but do share behaviors
The values in the objects' instance variables (states) are different, but they can call the same instance methods (behaviors) defined in the class.
Classes also have behaviors not for objects (class methods).
sub-classing from parent class. Can only sub-class from 1 parent; used to model hierarchical relationships
mixing in modules. Can mix in as many modules as needed; Ruby's way of implementing multiple inheritance
understand how sub-classing or mixing in modules affects the method lookup path
What will the following code output?

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
class Person
  attr_writer :first_name, :last_name

  def full_name
    # omitted code
  end
end

mike = Person.new
mike.first_name = 'Michael'
mike.last_name = 'Garcia'
mike.full_name # => 'Michael Garcia'

What code snippet can replace the "omitted code" comment to produce the indicated result? 
class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
priya.grade # => "A"

The last line in the above code should return "A". Which method(s) can we add to the Student class so the code works as expected?
In the example above, why would the following not work?

def change_grade(new_grade)
  grade = new_grade
end
On which lines in the following code does self refer to the instance of the MeMyselfAndI class referenced by i rather than the class itself? Select all that apply.


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

Given the below usage of the Person class, code the class definition.
Example:

class Person
  attr_accessor :first_name, :last_name
  
  def intialize(name)
    @first_name = name
    @last_name = ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    self.first_name = name.split.first
    self.last_name = name.split[1] ? namesplit[1] : ''
  end

  def ==(other)
    name == other.name
  end

  def to_s
    "This person's name is #{name}."
  end
end

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'
Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

Hint: let first_name and last_name be "states" and create an instance method called name that uses those states.
Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'
Using the class definition from step #3, let's create a few more people -- that is, Person objects.

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

Continuing with our Person class definition, what does the below print out?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
Let's add a to_s method to the class:

class Person
  # ... rest of class omitted for brevity

  def to_s
    name
  end
end
Now, what does the below output?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
Create an empty class named Cat.
Using the code from the previous exercise, create an instance of Cat and assign it to a variable named kitty.
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Chef
        preparer.prepare_food(guests)
      when Decorator
        preparer.decorate_place(flowers)
      when Musician
        preparer.prepare_performance(songs)
      end
    end
  end
end

class Chef
  def prepare(wedding)
    prepare_food(wedding.guests)
  end
end

class Decorator
  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_performance(songs)
    #implementation
  end
end

# The above code would work, but it is problematic. What is wrong with this code, and how can you fix it?
What happens when you call the p method on an object? And the puts method?
What is a spike?
When writing a program, what is a sign that you’re missing a class?
What are some rules/guidelines when writing programs in OOP?
class Student
  attr_accessor :grade

  def initialize(name, grade=nil)
    @name = name
  end
end

ade = Student.new('Adewale')
ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">
# Why does this code not have the expected return value?
class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{name} is speaking."
  end
end

class Knight < Character
  def name
    "Sir " + super
  end
end

sir_gallant = Knight.new("Gallant")
sir_gallant.name # => "Sir Gallant"
sir_gallant.speak # => "Sir Gallant is speaking."
# What change(s) do you need to make to the above code in order to get the expected output?
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
    "baaaaaaa!"
  end
end

class Cow
  def speak
    super + "mooooooo!"
  end
end

Sheep.new.speak # => "Sheep says baa!"
Lamb.new.speak # => "Lamb says baa!baaaaaaa!"
Cow.new.speak # => "Cow says mooooooo!"
# Make the changes necessary in order for this code to return the expected values.
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
Identify all custom defined objects that act as collaborator objects within the code. 
How does equivalence work in Ruby?
How do you determine if two variables actually point to the same object?
What is == in Ruby? How does == know what value to use for comparison?
Is it possible to compare two objects of different classes?
What do you get “for free” when you define a == method?
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr1.object_id == arr2.object_id      # => ??

sym1 = :something
sym2 = :something
sym1.object_id == sym2.object_id      # => ??

int1 = 5
int2 = 5
int1.object_id == int2.object_id      # => ??
# What will the code above return and why?
What is the === method?
What is the eql? method?
What is the scoping rule for instance variables?
class Person
  def get_name
    @name                     # the @name instance variable is not initialized anywhere
  end
end

bob = Person.new
bob.get_name                  # => ??
# What is the return value, and why?
What are the scoping rules for class variables? What are the two main behaviors of class variables?
What are the scoping rules for constant variables?
How does sub-classing affect instance variables?
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
puts teddy.dog_name                       # => ??
# What will this return, and why?
module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
teddy.swim                                  
# How do you get this code to return “swimming”? What does this demonstrate about instance variables?
Are class variables accessible to sub-classes?
Why is it recommended to avoid the use of class variables when working with inheritance?
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

Vehicle.wheels                              # => ??

class Motorcycle < Vehicle
  @@wheels = 2
end

Motorcycle.wheels                           # => ??
Vehicle.wheels                              # => ??

class Car < Vehicle
end

Car.wheels                                  # => ??
# What would the above code return, and why?
Is it possible to reference a constant defined in a different class?
What is the namespace resolution operator?
How are constants used in inheritance?
module Maintenance
  def change_tires
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

a_car = Car.new
a_car.change_tires             
# Describe the error and provide two different ways to fix it.
What is lexical scope?
When dealing with code that has modules and inheritance, where does constant resolution look first?
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
End

bob = Person.new("Bob", 49)
kim = Person.new("Kim", 33)
puts "bob is older than kim" if bob > kim
# How can you make this code function? How is this possible?
my_hash = {a: 1, b: 2, c: 3}
my_hash << {d: 4}  
# What happens here, and why?
When do shift methods make the most sense?
class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    members + other_team.members
  end
end

# we'll use the same Person class from earlier

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
dream_team = cowboys + niners               # what is dream_team?
# What does the Team#+ method currently return? What is the problem with this? How could you fix this problem?
Explain how the element getter (reference) and setter methods work, and their corresponding syntactical sugar.
How is defining a class different from defining a method?


How do you create an instance of a class? By calling the class method `new`
What are two different ways that the getter method allows us to invoke the method in order to access an instance variable?

`getter_method_name` || `self.getter_method_name`
When you have a mixin and you use a ruby shorthand accessor method, how do you write the code (what order do you write the getter/setters and the mixin)? What about using a constant?

mixin then accessor, constant then accessor
How do you define a class method?

Define a class method by prepending `self` to the method name.
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def rename(new_name)
    name = new_name
  end
end

kitty = Cat.new('Sophie')
p kitty.name # "Sophie"
kitty.rename('Chloe')
p kitty.name # "Chloe"
# What is wrong with the code above? Why? What principle about getter/setter methods does this demonstrate?

In the imethod `rename`, we need to prepend `self` to `name` on line 9, otherwise Ruby assumes we’re initializing a new local variable `name` and assigning it to the argument passed in through the parameter `name`. 
Self refers to the ______ _______. calling object
How do you print the object so you can see the instance variables and their values along with the object?

p object
When writing the name of methods in normal/markdown text, how do you write the name of an instance method? A class method?

`ClassName#instance_method_name`, `ClassName::class_method_name`
How do you override the to_s method? What does the to_s method have to do with puts?

You can override the to_s method by defining a to_s method in the relevant class. `puts` automatically calls `to_s` when outputting an object. 
# Using the following code, allow Truck to accept a second argument upon instantiation. Name the parameter bed_type and implement the modification so that Car continues to only accept one argument.

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def initialize(year, bed_type)
    super(year)
    @bed_type = bed_type
end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type


# Given the following code, modify #start_engine in Truck by appending 'Drive fast, please!' to the return value of #start_engine in Vehicle. The 'fast' in 'Drive fast, please!' should be the value of speed.

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + “Go #{speed} please!”
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')

# Expected output:

# Ready to go! Drive fast, please!


When do you use empty parentheses with super?

When you want to invoke a superclass methods and explicitly pass no arguments to the superclass method (to prevent an argument error)
How do you find the lookup path for a class? (lookup path stops when you find it)

Call the ancestors method on the class
What is namespacing, and how do you instantiate a class contained in a module?

Namespacing is grouping related classes, perhaps to prevent similarly named methods from colliding. You can instantiate a class contained in a module by using the namespace resolution operator, :: (Module::Class.new)
When using getters and setters, in what scenario might you decide to only use a getter, and why is this important?

You might only need a getter if you only want to access the data, but don’t want or need to be able to change it. 
When might it make sense to format the data or prevent destructive method calls changing the data by using a custom getter or setter method?

Any time you want to control how the user is able to access or change data - getters and setters protect the raw data


=end


# note : sample interview

=begin



what is polymorphism? example?

what are the two types of polymorphism? Example?

Why is polymorphism important? example?

What is self in ruby? How does self change depending on its scope? Examples?

How does multiple inheritance work in ruby? example?

class inhertance vs interface inheritance. examples?



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
puts teddy.swim   


why doesn't it print 'swimming!'?
how would we fix this so it prints 'swimming!'


module Definable
  def what_am_i
    "I am a #{bird_type} and I #{can/cant} fly."
  end
  
  def self.some_method
    'something...'
  end
end

class Bird
  include Definable
  
  def initialize(name)
    @name = name
  end
  
  def self.family
    self
  end
  
end

class Penguin < Bird
  
  def name
    "My name is #{name} and I am a #{penny.class}."
  end
  
end

class Hawk < Bird
end

penny = Penguin.new('Penny')
hawky = Hawk.new('Hawky')

penny == hawky #=> false

penny.same_family?(hawky) #=> true

p penny.what_am_i #=> "I am a Penguin and I can't fly"
p hawky.what_am_i #=> "I am a Hawk and I can fly"

p penny.name #=> "My name is Penny and I am a pengiun."
p hawky.name #=> "My name is Hawky and I am a hawk."



module Definable
 
end

class Bird
  include Definable
  
  def initialize(name)
    @name = name
  end

end

class Penguin < Bird
 
end

class Hawk < Bird
end

penny = Penguin.new('Penny')
hawky = Hawk.new('Hawky')

=end