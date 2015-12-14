import UIKit

// let and var
// only use var when you expect to change the value
let pi: Double = 3.14159
var diameter: Double = 5
var circumference: Double

circumference = diameter * pi
diameter = 10
circumference = diameter * pi

// type conversions are never implicit
let intValue:       Int    = 10
//let badDoubleValue: Double = intValue
let doubleValue:    Double = Double(intValue)

// type inference
let pie = 3.14159

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
//print( "\(something)" )

// string formatting - use \()
let displayText = "A circle w/a diameter of \(diameter) has a circumference of \(circumference)"


// optional values (aka nullable)
// By making the use of optionals very deliberate, Swift is able to catch many nil pointer errors
// at compile time instead of run time.
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

// "shadowing" enables the unwrapped value to have the name as the optional value
if let name = name
{
    print( "Hello \(name)" )
}

// guard



// for loop & using ranges
// see results in debug area
for i in 0...4
{
    let outputStr = "i is \(i)"
    print( outputStr )
}

let simpleArray = ["zero", "one", "two"]
for index in 0..<simpleArray.count
{
    print( "simpleArray item at index \(index): \(simpleArray[index])" )
}


// switch case
// no need for break
// can match on strings, logic statements
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


// functions
func greetingForName( name: String ) -> String
{
    return "Hello \(name)"
}

// when calling a function, the first param is not named, but all remaining params include the name
greetingForName( "Amy" )


// tuples
func fullNameForUserId( userId: String ) -> (first: String, last: String)
{
    return ("Amy", "Pond")
}

let fullName = fullNameForUserId( "asdf" )
fullName.first
fullName.0


// closures
// notice the syntax for defining params
func fullNameForUserId( userId: String, completion: (fullName: (first: String, last: String) ) -> Void )
{
    // async call to web service...
    
    completion( fullName: ("Amy", "Pond") )
}

fullNameForUserId( "asdf") { (fullName) -> Void in
    let firstName = fullName.first
    let lastName = fullName.last
}


// classes
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
person.firstName
person.lastName


// structs
// Swift structs can do much of what classes can do including properties and methods as well as
// implement protocols.
// but structs do not allow inheritance and are passed by value, not reference.
// Prefer struct over class when the primary purpose is to encapsulate a few relatively simple data values. See Apple's docs for full explanation - "Choosing Between Classes and Structures" section https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html
// There are many cases where structs are preferred where classes have traditionaly been used.




// enumerations
// raw value types can be numeric (int, float, etc.), character or string
enum ClubStatus: Int
{
    case notEnrolled = 1
    case enrolled
    case newTermsOptional
    case newTermsRequired
    case inactive
    case declined
    
    func label() -> String
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
status.rawValue
status.label()

enum OtherStatus: String
{
    case notEnrolled = "Not Enrolled"
    case enrolled = "Enrolled"
}

let strStatus = OtherStatus.enrolled
strStatus.rawValue


// protocols & extensions

