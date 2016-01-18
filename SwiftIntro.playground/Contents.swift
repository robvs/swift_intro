import UIKit

/*******************************************************************************
 Target audience is experienced developers who are not familiar with swift.

 Part 1 of 2
 A quick tour of basic Swift syntax and language features.
*/

// For more complete details on any topic, see Apple's documentation:
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309



print( "***** let and var *****" )


// declaring constants and variables
// use let by default, use var only when you expect the value to change.
let pi:            Double = 3.14159
var diameter:      Double = 5
var circumference: Double

circumference = diameter * pi
diameter      = 10
circumference = diameter * pi

// notice there are no semicolons. they are allowed, but discouraged.


// with let, struct types are immutable but class instances are not.
// note that arrays and dictionaries are struct types.
let names:        [String] = ["Fred", "Wilma"]
var mutableNames: [String] = ["Fred", "Wilma"]

mutableNames[0] = "Barney"
//names[0]      = "Barney"

class Names
{
    var name1 = "Fred"
    var name2 = "Wilma"
}
let namesObj = Names()
namesObj.name1 = "Barney"


// type conversions are never implicit
let intValue:       Int    = 10
let doubleValue:    Double = Double(intValue)

//let badDoubleValue: Double = intValue


// type inference
let pie = "apple pie"
let pi_ = 3.14159


// trying to use a name before it is initialized is a compiler error
let something: Double
let asdf = 2
if asdf == 1
{
    something = 1.0
}
else if asdf == 2
{
    something = 2.0
}
//let somethingPlusOne = something + 1.0


// string formatting - use \()
print( "A circle w/dia of \(diameter) has a circ of \(circumference)" )


print( "\n***** Optionals *****" )


// optional values (aka nullable)
// By being  deliberate about declaring a value as optional, Swift is able
// to catch many nil pointer errors at compile time instead of run time.
//var name: String = nil
var name: String? = nil
name = "Amy Pond"

if name != nil
{
    print( "Hello \(name!)" )
}

if let unwrappedName = name
{
    print( "Hello \(unwrappedName)" )
}

// "shadowing" enables the unwrapped value to have the name as the 
// optional value
if let name = name
{
    print( "Hello \(name)" )
}


print( "\n***** guard and the Pyramid of Doom *****" )
/**
 Also see "When (not) to use guard" - http://radex.io/swift/guard/
*/


// unwrapping a group of obtional values
let a: Int? = 1
let b: Int? = 2
let c: Int? = 3

if let a = a
{
    if let b = b
    {
        if let c = c
        {
            print( "a + b + c = \(a + b + c)" )
        }
    }
}

// this can be rewritten using a shorthand syntax
if let a = a, b = b, c = c
{
    print( "a + b + c = \(a + b + c)" )
}

// using guard to do early error checking in a function and avoid the 
// pyramid of doom
func addThreeOptionalValues( x: Int?, y: Int?, z: Int? ) -> Void
{
    guard let x = x else {
        print( "An 'x' value is required" )
        return
    }
    guard let y = y else {
        print( "A 'y' value is required" )
        return
    }
    guard let z = z else {
        print( "A 'z' value is required" )
        return
    }
    
    // at this point, x, y and z are unwrapped and we know that all have 
    // valid values
    
    print( "x + y + z = \(x + y + z)" )
}

// test it...
addThreeOptionalValues( a, y: b, z: c )
addThreeOptionalValues( a, y: nil, z: c )


print( "\n***** for Loops and Ranges *****" )


// loop on a range of values
for i in 0...4
{
    let outputStr = "i is \(i)"
    print( outputStr )
}

// syntax for half-open range - does not include the final value
let simpleArray = ["zero", "one", "two"]
for index in 0..<simpleArray.count
{
    print( "simpleArray item at index \(index): \(simpleArray[index])" )
}


print( "\n***** switch *****" )


// no need for break
// can match on strings & logic statements
let phoneNumber = "616-555-1212"
switch phoneNumber
{
case "616-555-1234":
    print( "Marge's" )
case "616-555-4321":
    print( "Sandy's" )
case let localNumber where localNumber.hasPrefix("616"):
    print( "\(localNumber) is an unknown local number" )
default:
    print( "\(phoneNumber) is out of the area" )
}


print( "\n***** functions *****" )


// return type syntax is a little odd.
func greetingForName( firstName: String, lastName: String ) -> String
{
    return "Hello \(firstName) \(lastName)"
}

// when calling a function, the first param is not named, but all remaining
// params include the name
let greeting: String = greetingForName( "Amy", lastName: "Pond" )
print( greeting )


print( "\n***** tuples *****" )


// tuples group multiple values into a single compount value.
// in some ways similar to annonymous classes in C#.
func fullNameForUserId( userId: String ) -> (first: String, last: String)
{
    return ("Amy", "Pond")
}

let fullName = fullNameForUserId( "asdf" )
fullName.first
fullName.0
print( fullName )


print( "\n***** closures *****" )
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94


// closures are self-contained blocks of functionality that
// can be passed around. they are often used as a completion
// parameter in asyncronous functions.
//
// notice the syntax is very similar to defining a function.
func getFullNameForUserId( userId: String,
                           completion: (firstName: String, lastName: String) -> Void )
{
    // executing the provided closure is exactly like calling a function
    completion( firstName: "Amy", lastName: "Pond" )
}

// if a closure is the last parameter of a function, it can be
// written as a 'trailing closure' where it is written outside
// of the function's closing parentheses.
getFullNameForUserId( "1234" ) { (firstName, lastName) -> Void in
    let first = firstName
    let last = lastName
    
    print( "Full name is \(first) \(last)" )
}


print( "\n***** enumerations *****" )
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145


// raw value types can be numeric (int, float, etc.), character or string.
// enums include support for computed properties and instance methods.
enum ClubStatus: Int
{
    case notEnrolled = 1
    case enrolled
    case newTermsOptional
    case newTermsRequired
    case inactive
    case declined
    
    var label: String
        {
            switch self
            {
            case .notEnrolled:
                return "Not Enrolled"
            case .enrolled:
                return "Enrolled"
                // etc.
            default:
                return String( self.rawValue )
            }
    }
}

let status = ClubStatus.enrolled
print( "status raw value: \(status.rawValue), label: \(status.label)" )

enum ClubStatusAsString: String
{
    case notEnrolled = "Not Enrolled"
    case enrolled = "Enrolled"
}

let strStatus = ClubStatusAsString.enrolled
print( strStatus.rawValue )


print( "\n***** classes & structures *****" )
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82


// difining and instantiating a class is very similar to other modern languages
class Person
{
    // properties
    var firstName: String
    var lastName: String
    
    // initializers
    init( firstName: String, lastName: String)
    {
        self.firstName = firstName
        self.lastName = lastName
    }
}

var person = Person( firstName: "Rose", lastName: "Tylor" )
print( "Person frist name is \(person.firstName)" )


// Swift structs can do much of what classes can do including 
// encapsulation of properties and methods as well as implement 
// protocols. but structs do not allow inheritance and are 
// passed by value, not reference.
struct User
{
    // properties
    var firstName: String
    var lastName: String
    
    // functions
    func fullName() -> String
    {
        return "\(firstName) \(lastName)"
    }
}

// structs have an automatically-generated memberwise initializer.
var user = User( firstName: "Rose", lastName: "Tylor" )
print( "User frist name is \(user.firstName)" )

// Prefer struct over class when the primary purpose is to 
// encapsulate a few relatively simple data values. See Apple's 
// docs for full explanation - "Choosing Between Classes and 
// Structures" section https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html

