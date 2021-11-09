# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

# REFERENCING & SETTING INSTANCE VARIABLES VS. SETTING & GETTING METHODS \***\*\*\*\*\*\***

# WHY is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to set an instance variable within the class? Give an example.

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

=begin
It is generally better to use setter and getter methods when trying to set and retrieve an instance variable rather than reference the instance variable directly. One reason being that setter and getter methods allow us to create general functionality in method definitions that we can use whenever we want to either retrieve or set an instance variable. This could be partially hiding the raw data (like for SSN's) or formatting the data (like phone #'s to (**_) _**-\*\*\* ). Getters and setters also allow for more maintainability when those desired functionalities of retrieving and setting instance variables may change in the future. Setter and getter methods play an important role in keeping our code DRY, readable and maintainable.
=end

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

# Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

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

=end

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

# What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

=begin
The `attr_accessor` method takes symbols as arguments and creates getter and setter methods with the same name as the symbol for each symbol passed in.
If an instance variable is never changed and/or viewed then the `attr_accessor` is eccessive and our code should be clean and not include code that is never used. Because the `attr_accessor` creates both setter and getter methods if used on every instance variable it will create a scenerio where sensitive data that should not be changable will be changable and possibly create a bug.

For example:
class Student
attr_accessor :name, :student_id

def initialize(name, student_id)
@name = name
@student_id = sudent_id
end

In this example both the @name and @student_id have getter and setter methods, but in reality the student_id should not be changable. Viewable with attr_reader, yes, but the student id of a student should not be changable (at least not this easily).
=end

# 20**\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

# What is the difference between states and behaviors?

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

=begin
Instance variables represent the state of an object. The methods defined in the class provide the behavior of an object. Every object has its own unique state. However, they share the same behaviors defined in the methods in the class.
=end

# 21.**\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

# What is the difference between instance methods and class methods?

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

=begin
Instance methods are methods available to each instanciated object of a class, but do not have access to the class methods. Class methods are methods invocable by the class directly and do need an instantiated object, however classes cannot invoke instance methods directly.
=end

# 22.**\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

# What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

=begin
Collaborator objects are objects of different types that share an associative relationship. Collaborator objects can be any type and are a part of another object's state.

For example:
class Owner
def initialize(name)  
 @name = name
@pet = Pet.new
end
end

joe = Owner.new('joe')

In the example above the string object `joe` assigned to instance variable `@name` and the new Pet object assigned to the instance variable @pet are both collaborator object of the object `joe`.
=end

# 23.**\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

# How and why would we implement a fake operator in a custom class? Give an example.

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

=begin
Fake operators are used in custom classes to make code more readable and to add functionality. Fake operators are created like any other method with a parameter:
class Person
attr_reader :name

def initialize(name)
@name = name
end

def <=>(other_person) #the fake operator
name <=> other_person.name
end
end

joe = Person.new('joe')
mack = Person.new('Mack')

p [mack, joe].sort => [joe, mack]

In this case the fake operator `<=>` tells ruby too compare the names of the objects when `Person` object is compared with other objects. This functionality allows us to then sort our objects alphabetically based on the objects' name.
=end

# 24.**\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

# What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? Provide examples.

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

=begin
`Self` is a keyword that points to the object that 'owns' the currently executing code. `Self` is used for looking up instance variables, methods and constants, defining class methods, debugging, comparing current object with other objects, .

When used in the naming of a method within a class:
def self.some_method; end,
the `self` in this case will point to the class the method is located in, making this method a class method.

When used inside a method of a class:
def some_method
self
end
the `self` will point to the instantiated object of the class, making this an instance method.

When used within module methods the `self` keyword will point to the object the module is mixed into.
module Some_mod
def me
self
end
end

If `self` is part of the naming of a method in a module:
module Some_mod
def self.me
end
end
then the `self` in this case will point to the module itself, not the object it is mixed into.

When `self.instance_var` is called within an instance method, Ruby will search for the method `instance_var`. In this case we are looking to get the value of an instance variable and `self.instance_var` will find the getter method of `instance_var` and call it to get the value of `instance_var`.
=end

# 26.**\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***

# How do class inheritance and mixing in modules affect instance variable scope? Give an example.

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

=begin
Instance variables can be mixed in and will take precidence over parent classes. In the example below we can see that the output will be the value "mack" of `@name` in the module, not the parent class's `@name` "bill".

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

If the instance variable referenced is not found in any of the included modules ruby will then look for them in the parent classes.
=end

# 27.**\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***

# How does encapsulation relate to the public interface of a class?

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

=begin
Encapsulation determines what within a class is public/external and what is private/internal. Public/external interfaces are attributes and methods accessible from outside the class. Private/internal interfaces are attributes and methods that are only accessible from inside the class. Unless explicitly stated all methods within a class are public interfaces by default. Ruby requires methods within a class to be explicitly labeled private to be made unaccessible to external interfaces.  
=end

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

# When does accidental method overriding occur, and why? Give an example.

# **\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***

=begin
Accidental method overriding occurs when a method in a custom class accidentally has the same name as a preexisting method. If this was done on purpose it would be called monkey patching instead. Accidental method overriding can happen when a developer is unaware of a method already existing and using that methods name to create a new method in a custom class. Overriding can happen to Ruby's preexisting methods or methods of custom parent classes.

class Person
def send
some new code
end
end

`send` is a preexisting Ruby method for the object class. By creating a new method `send` in the `Person` class we are overriding the ruby method and instances of `Person` can no longer invoke it, but can only invoke the new `send` instance method in the `Person` class.
=end

# **\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***\*\*\***\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***

# How is Method Access Control implemented in Ruby? Provide examples of when we would use public, protected, and private access modifiers.

# **\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***\*\*\***\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***

=begin
Method access control in ruby is implemented by controlling the access to the methods within its classes using the `public`, `private` & `protected` access modifier methods. By controlling the access to its methods, we are able to control which interfaces are private and which are public. All instance methods other than `initialize` are public by default and are accessible to to all public interfaces. Protected and private methods are only accessible within the class definition (private interfaces). However, protected methods can be accessed by other instances of the same class.

class Person

def initialize(name, dob, age)
@name = name
@dob = dob
@age = age
end

def name #public method
@name
end

#calls a protected method of a different object that share the same class
def compare_age(other_p)
if age > other_p.age
puts "#{name} is older the #{other_p.name}."
else
puts "#{other_p.name} is older the #{name}."
end
end

def print_b_day # calls a private method from within the instance
dob = self.dob[0..1].join('/')
puts dop
end

protected

def age #protected method
@age
end

private

def dob
@dob.split("/") =>[mm,dd,yyyy]
end
end
=end

# **\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***\*\*\***\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***

# Describe the distinction between modules and classes.

# **\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***\*\*\***\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***

=begin
Classes define the attributes and behaviors of all objects in Ruby. All objects in Ruby are instances of classes. Attributes and behaviours can be inherited from parent classes by child classes through class inheritance. Modules on the other hand do not define objects and cannot be instantiated. Modules are used to store methods, classes and constant. Modules are able to add their stored methods, classes and constants to classes that require them through mixing the module into the class, called interface inheritance.
=end

# **\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***

# What is polymorphism and how can we implement polymorphism in Ruby? Provide examples.

# **\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***\***\*\*\*\***\*\*\*\***\*\*\*\***\*\***\*\*\*\***\*\*\*\***\*\*\*\***

=begin
Polymorphism occurs when a method can interace with multiple types of objects (known as pure polmorphism), when multiple methods share the same name but have a different number of parameters (known as overloading) and when a subclass has a method with the same name as a method in its superclass, hence overridding the superclass method.

=end

# **\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***\*\*\***\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***

# What is encapsulation, and why is it important in Ruby? Give an example.

# **\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***\*\*\***\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***

=begin

=end

# **\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***\*\*\***\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***

# Parent class vs module

# **\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***\*\*\***\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***

=begin
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

# **\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***\*\*\***\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***

# What is returned/output in the code? Why did it make more sense to use a module as a mixin vs. defining a parent class and using class inheritance?

# **\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***\*\*\***\*\***\*\*\*\***\*\***\*\***\*\***\*\*\*\***\*\***

There is no immediate association between `Cat` and `Person` that would serve as a logical parent class for both. Hence a module is useful to add functionality to multiple classes that require functionality but do not share a logical parent class.

=end
