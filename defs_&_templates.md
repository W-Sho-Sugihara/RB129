# 00 What is OOP?

# AA Classes and Objects

# AA1 Objects

# AA2 Classes

# AA3 Object Instantiation

# AA4 Instance Variables

# AA5 Instance Methods

# AA6 Class Variables

# AA7 Class Methods

# AA8 Note on Terms

# AA9 Instance Methods vs Class Methods

# BB Setter and Getter Methods

# BB1 Getter Methods

# BB2 Setter Methods

# BB3 Using attr\_\*

# CC Method Access Control

# CC1 Public

# CC2 Private

# CC3 Protected

# DD Inheritance

# DD1 Class Inheritance

# DD2 Interface Inheritance

# DD3 Method Lookup Path

# DD4 Super

# DD5 Object Methods

# DD6 Variable Scope with Inheritance

# EE Polymorphism & Encapsulation

# EE1 Polymorphism

# EE2 Polymorphism Through Inheritance

# EE3 Polymorphism Through Duck Typing

# EE4 Encapsulation

# FF Modules

# FF1 Mixin Modules

# FF2 Namespacing

# FF3 Module Methods

# GG Self

# GG1 Inside Instance Methods

# GG2 Inside Class Methods

# GG3 Inside Class Definitions

# GG4 Inside Mixin Modules

# GG5 Outside Any Class

# HH Fake Operators and Equality

# HHa Equivalence

# HHa1 ==

# HHa2 equal? and object_id

# HHa3 ===

# HHa4 eql?

# HHb Fake Operators

# HHb1 Comparison Methods

# HHb2 Plus

# HHb3 Element Setters and Getters

# II Collaborator Objects

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

# New Section OOP

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

=begin
OOP is a programming paradigm that uses classes and objects to organize both data as attributes and procedures as methods. Classes are used as a blueprint to determine the attributes and methods of an object. An object is an instance of its class and it is upon instantiation that the values of its predefined attributes are given values.

OOP uses inheritance to allow parent classes to share methods with child classes, encapsulation to restrict access to certain data and methods, polymorphism to allow method overiding, method overloading (but not in ruby) and allow different object types to be passed into the same interface.
Inheritance, encapsulation and polymorphism allows OOP to create and structure code that is more flexible, resuable and maintainable.
=end

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

# AA New Section Classes and Objects

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

# AA1sub-section Objects

=begin
Objects contain data about their current state and behavior. Classes provide the templates from which objects are created. An object is an instance of a class. Each instance of a class is unique even if they share the same class.

Example:

1.class => Integer
2.class => Integer
"Hi".class => String
"Hello".class => String

=end

# AA2sub-section Classes

=begin
Classes are the templates from which objects are created. The attributes and behaviors of objects in Ruby are defined in its class.  
=end

# AA3sub-section Object Instantiation

=begin
When an object is created from a class it is called instantiation, in other words, an object is an instance of a class.

Example:

class Person; end

joe = Person.new

=end

# AA4sub-section Instance Variables

=begin
Instance variable are variables within an instantiated object begining with an `@` mark. Instance variables contain the state of an object instance and are scoped to the object instance. The values of the instance variables are what make each object unique.
=end

#AA5sub-section Instance Methods
=begin
Instance methods are the methods accessible to instances of a class. They cannot be invoked by the class itself and must be invoked by an object instance.
=end

#AA6sub-section Class Variables
=begin
Class variables are variables within a class begining with `@@`. Class variables are shared by all instances of that class unlike instance variables that are unique for each instance. Class variables are also inherited. Class variables are accessible by both class and instance methods.
=end

#AA7sub-section Class Methods
=begin
Class methods are methods that are invokable only by the class itself and not by an instance of that class. Class methods begin with `self` te distinguish between class and instance methods.

Example:

class SomeClass
def self.some_method #class method because it begins with `self`
#code
end
end

=end

#AA8sub-section Note on Terms
=begin

=end

#AA9sub-section Instance Methods vs Class Methods
=begin
Instance methods: methods inside the class that an object can call once instantiated.

Class methods: methods that are called on the class directly and not from instatiated objects.
=end

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

# BB New Section Setter and Getter Methods

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

=begin
It is generally better to use setter and getter methods when trying to set and retrieve an instance variable rather than reference the instance variable directly. One reason being that setter and getter methods allow us to create general functionality in method definitions that we can use whenever we want to either retrieve or set an instance variable. This could be hiding the raw data (like for SSN's) or formatting the data (like phone #'s to (**_) _** - \*\*\*\* ). Getters and setters also allow for more maintainability when those desired functionalities of retrieving and setting instance variables may change in the future. Setter and getter methods play an important role in keeping our code DRY, readable and maintainable.
=end

# BB1sub-section Getter Methods

=begin
Getter methods are instance methods that allow us to view the value of an instance variable.

Example:

class Person
def initialize(name)
@name = name
end

def name # getter method
@name
end
end
=end

#BB2sub-section Setter Methods

=begin
Setter methods are instance methods that allow us to reassign the value of an instance variable.

Example:

class Person
def initialize(name)
@name = name
end

def name=(new_name) # setter method
@name = new_name
end
end
=end

#BB3sub-section Using attr\_\*

=begin
`attr_accessor` is a method that takes symbols as an argument and uses them to creates getter and setter methods. `attr_*` methods simplifies creating getter and setter methods for instance variables by replacing multiple lines of code that would have been needed to create getter and/or setter methds for each instance variable.

    attr_accessor :name, :age, :dob

`attr_reader` is a method that takes symbols as an argument and creates getter methods with the same name as the symbol. `attr_*` methods simplifies creating getter and setter methods for instance variables by replacing multiple lines of code that would have been needed to create getter and/or setter methds for each instance variable.

    attr_reader :name, :age, :dob

`attr_writer` is a method that takes symbols as an argument and creates setter methods with the same name as the symbol. `attr\_\*`` methods simplifies creating getter and setter methods for instance variables by replacing multiple lines of code that would have been needed to create getter and/or setter methds for each instance variable.

    attr_writer :name, :age, :dob

=end

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#CC New Section Method Access Control

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

=begin
Method access control in ruby is implemented by controlling the access to the methods within its classes using the `public`, `private` & `protected` access modifiers. By controlling the access to its methods, we are able to control which interfaces are private and which are public.
=end

#CC1sub-section Public
=begin
All instance methods other than `initialize` are public by default and are accessible to to all public interfaces.
=end

#CC2sub-section Private
=begin
The `pivate` method makes the methods following it private and only accessible with other methods within the current class instance. Interfaces of other instances (including the same class type) cannot access private methods. Instance variables are also private by default and are only veiwable and settable by use of methods.
=end

#CC3sub-section Protected
=begin
The `protected` method makes the methods following it protected and only accessible with other methods within the current class instance and by other instances of the same class. From within the class `protected` methods act like public methods and from outside the class they act like `private` methds. Hence when other instance objects call protected methods from within the class they do not raise an error.
=end

=begin
Example:

class Person

def initialize(name, dob, age) #private method
@name = name
@dob = dob
@age = age
end

def name #public method
@name
end

def compare_age(other_p) #public method
#calls a protected method of a different object
if age > other_p.age
puts "#{name} is older the #{other_p.name}."
else
puts "#{other_p.name} is older the #{name}."
end
end

def print_b_day # calls a private method from within the instance
dob = self.dob[0..1].join('/')
puts dob
end

protected

def age #protected method
@age
end

private

def dob #private method
@dob.split("/") #=>[mm,dd,yyyy]
end
end

class Pet
def compare_age(other_p)
#calls a protected method of a different object
if 10 > other_p.age
puts "#{name} is older the #{other_p.name}."
else
puts "#{other_p.name} is older the #{name}."
end
end
end

joe = Person.new("joe", '11/22/1999', 40)
joe.name # => "joe", because `name` is a public method and can be called outside the class
mack = Person.new("mack", '11/22/1999', 30)
joe.compare_age(mack) # => will not raise an error because same classes

momo = Pet.new
momo.compare_age(joe) # => will raise an error, because they are different classes

=end

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#DD New Section Inheritance

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#DD1sub-section Class Inheritance
=begin
Attributes and behaviours are inherited from superclasses by subclasses classes through class inheritance. Through inheritance a subclass has access to the behaviors of their superclasses. A class can only have one superclass, but can be inherited by multiple classes.
=end

#DD2sub-section Interface Inheritance
=begin
Interface inheritance is when a class inherits the interfaces of a module mixin. Once interface inheritance takes place in a superclass, subclasses will inherit those behaviors through class inheritance.
=end

#DD3sub-section Method Lookup Path
=begin
Method lookup path is the hierarchical order ruby will inspect in a class to find a method. It begins in the class of the object instance, then looks at the mixins of the current class beginning with the last mixed in module up to the first (bottom to top order), them moves on the the superclass, if not found then looks at the mixins of the superclass beginning with the last mixed in module up to the first (bottom to top order), and so on up superclasses until the called method is found and executed or is never found and raises an error.
=end

#DD4sub-section Super
=begin
The `Super` keyword is used when a method in a subclass has overridden a method of a superclass but still desires to use the functionality of the overridden method in the superclass. When the `super` keyword is added to a method definition and the method is invoked, `super` will search the method lookup path for a method of the same name as the current method and invoke it.
=end

#DD5sub-section Object Methods
=begin

=end

#DD6sub-section Variable Scope with Inheritance
=begin
Instance variables are scoped to their object instances and can be referenced anywhere in the class definition. All instance variables in the superclasses are also scoped to the instantiated object. The scope of class variables are shared among all instances of the class and all instances of its subclasses.

Example:
class Parent

def initialize(name)
@name = name
@@grandpa_quote = "greatest grandpa"
end
end

class Child < Parent; end

class Grandchild < Child

def name
@name
end

def grandpa_quote
@@grandpa_quote
end

def grandpa_quote=(v)
@@grandpa_quote = v
end
end

matt = Grandchild.new('matt')
bill = Grandchild.new('bill')

p matt.grandpa_quote # => "greatest grandpa"
p bill.grandpa_quote # => "greatest grandpa"

matt.grandpa_quote = "better than grandma"

p matt.grandpa_quote # => "better than grandma"
p bill.grandpa_quote # => "better than grandma" because the class variable `@@grandpa_quote` is shared by both `matt` and `bill`.
=end

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#EE New Section Polymorphism & Encapsulation

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#EE1sub-section Polymorphism
=begin
Polymorphism is when different data types respond to a common interface differently. For example, two different objects types have a method of the same name and when that method is called the method will not care which of the two objects is calling it. This is polymorphism.

Example:

array = ["string", [1,2,3], { My: "Hash" }]

array.each do |obj|
p obj.empty?
end

In the above example the array contains three different object types, a string, an array, and a hash. Iterating through this array we call the `empty?` method on each object in the array without raising an error. We can see through this example that the `empty?` method is polymorphic because it was called on different data types and still worked.

=end

#EE2sub-section Polymorphism Through Inheritance
=begin
Polymorphism occurs through inheritance when a method in a superclass is overridden in a subclass method. Each subclass of a supclass could each have its own version of a method in a superclass.
Example:

class Parent
def initialize(name)
@name = name
end
def favorite_food
puts "#{self}'s favorite food is sushi!"
end

def to_s
@name
end
end

class Oldest_son < Parent
def favorite_food
puts "#{@name}'s favorite food is pizza!"
end
end
class Oldest_daughter < Parent
def favorite_food
puts "#{@name}'s favorite food is icecream!"
end
end
class Second_son < Parent
def favorite_food
puts "#{@name}'s favorite food is mac 'n' cheese!"
end
end
class Second_daughter< Parent
def favorite_food
puts "#{@name}'s favorite food is pizza!"
end
end

joe = Oldest_son.new('joe')
mack = Second_son.new('mack')
eli = Oldest_daughter.new('Eli')
liz = Second_daughter.new('Liz')

arr = [joe, mack, eli, liz]

arr.each { |child| child.favorite_food }

This example demonstrated polymorphism through overriding methods, because each subclass of the superclass `Parent` contain a method `favorite_food` but each have unique functionality. Hence we can call `favorite_food` on all the subclasses of `Parent` and all will output a different result.
=end

#EE3sub-section Polymorphism Through Duck Typing
=begin
Polymorphism through duck typing is when unrelated objects have methods of the same name. Because duck typing is unconcerned with the object type all that is important is that the object has the method with the same name.
For Example:

array = ["string", [1,2,3], { My: "Hash" }]

array.each do |obj|
p obj.empty?
end

The objects in `array` are all different types and are unrelated. However, the `empty?` method doesn't care that the objects are different as long as they all have an instance method `empty?`. We can thus say that the method `empty?` is polymorphic and this example is an example of polymorphism through duck typing.
=end

#EE4sub-section Encapsulation
=begin
Encapsulation allow us to determine what information within an object is accessible outside the object, in other words, what within an object is pulic and what is private. Ruby uses method access controls to inplement encapsulation.  
=end

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#FF New Section Modules

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

=begin
Modules are a collection of methods, constants and classes. Modules cannot be instantiated, but are mixed into classes when the methods, constants or classes within the module are needed inside a certain class. Modules can be inherited by subclasses if they are mixed into the superclass. Modules allows for flexible resuability as modules can be mixed into any class and a class can have multiple modules.  
=end

#FF1sub-section Mixin Modules
=begin
Mixing modules into classes allow us to add behaviors to multiple classes that do not have a logical parent class which to add the desired behaviors. Mixed in behaviors will be inherited by subclasses of the class where the modules are mied into. Mixins allow more flexibility and reusability while keeping our code DRY. A class can have multiple mixins.

Example:
module Drivable
def drive
"Driving"
end
end

class F1_Racer
include Drivable
end

class Parent
include Drivable
end

class Teenager < Parent
end

Teenager.new.drive #=> "Driving"
=end

#FF2sub-section Namespacing
=begin
Namespacing referse to using modules to store similar classes and methods. This allows to better organize code by grouping similar classes and/or methods together and to prevent possible collision of similarly names classes and/or methods.

Example:

module Pets
class Dog; end

class Cat; end

class Goldfish; end

class Hamster; end
end

=end

#FF3sub-section Module Methods
=begin
Modules can have their own methods just like class methods. Module methods are used when a random or seemingly unrelated behavior is required in the code. If there is no logical place within classes or mixins for a particular code that might indicate it should be a module method.

module Other
def number_0_to_100
rand(100)
end
end

=end

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#GG New Section Self

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#GG1sub-section Inside Instance Methods
=begin
`Self` inside instance methods refers to the object instance calling the method.
=end

#GG2sub-section Inside Class Methods
=begin
`Self` inside class methods refers to the class object calling the method.
=end

#GG3sub-section Inside Class Definitions
=begin
`Self` inside class definitions refer to the class object.
=end

#GG4sub-section Inside Mixin Modules
=begin
`Self` in instance methods from mixins will refer to the object instance calling the method. If `self` is within a module method then `self` will reference the module object.
=end

#GG5sub-section Outside Any Class
=begin
`Self` outside any class will reference the `main` instance object of Ruby's `Object` class.
=end

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#HH New Section Fake Operators and Equality

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#HHa New Section Equivalence

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#HHa1sub-section ==
=begin
The BasicObject method `==` compares two objects to see if they are the same object. This method has been overridden in many subclasses and have different functionality depending on the calling class. For example, String `==` method will compare the value of the objects instead of the objects themselves ("string" == "string" => true).
=end

#HHa2sub-section equal? and object_id
=begin
The `equal?` method will test to see if two object point to the same space in memory, or in other words see if they are the same object.
=end

#HHa3sub-section ===
=begin
The `===` method will compare the caller and the passed in argument and see if the argument is part of the calling group. For example, String === 'Hi" will return `true` because `'Hi'` is part of the String class group, so to speak. Another example, (0..10) === 4 would also return `true` because 4 is a part of the range 0 through 10.
=end

#HHa4sub-section eql?
=begin
The `eql?` method will compare two objects to see if they contain the same values and if they are the same object. Used most often by `Hash`, it is not used very frequently.
=end

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#HHb1 New Section Comparison Methods

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

#HHb1sub-section Comparison Methods
=begin
When comparing objects we creat and instance method with the `<=>` to specify what we want to compare and the mixin module `Comparable`.

Example:

class Person
include Comparable

attr_reader :age

def initialize(age)
@age = age
end

def <=>(other)
age <=> other.age
end
end

joe = Person.new(30)
mack = Person.new(31)

joe > mack #=> fasle

=end

#HHb2sub-section Plus
=begin
The `+` method is not a predefined method in Ruby objects. Therefore is we wanted to impliment a `+` method we would have to write a new instance method.
Example:

class Person
attr_reader :age

def initialize(age)
@age = age
end

def +(other)
age + other.age
end
end

joe = Person.new(30)
mack = Person.new(31)

joe + mack #=> 61
=end

#HHb3sub-section Element Setters and Getters
=begin
`[]=`, and `[]` are both array methods `Array#[]=()` and `Array#[]()` respectively. These can be added to classes to create unique functionality in conjunction with arrays.

For Example:

class List
attr_accessor :list

def initialize
@list = []
end

def [](i)
list[i].name
end

def []=(i, task)
list[i] = Task.new(task)
end
end

class Task
attr_reader :name

def initialize(name)
@name = name
end
end

moms_list = List.new
moms_list[0] = 'grocery shopping'

=end

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

# II New Section Collaborator Objects

# ******************\*\*\*\*******************\*\*******************\*\*\*\*******************

=begin
Collaborator objects are objects in different classes that share an associative relationship. Collaborator objects can be any object type and are a part of a different objects state.

For Example:
class Person
def initialize(name, friend = nil)
@name = name
@friend = friend
end
end

joe = Person.new('joe') #=> The string object 'joe' assigned to instance variable `@name` is now a collaborator object for the new `Person` object `joe`

mack = Person.new('mack', joe) #=> The `joe` object is now a collaborator object of object instance `mack` because `joe` is now part of `mack`'s state by being assigned to `mack`'s instance variable `@friend`.
=end
