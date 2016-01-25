import UIKit

/*******************************************************************************
 Target audience is experienced developers who are not familiar with swift.
 This tutorial focuses more on some of the important concepts in swift than
 the syntax. It's easy enough to use reference materials for details on syntax.

 Part 2 of 3
 A quick tour of basic Swift syntax and language features.
*/

// For more complete details on any topic, see Apple's documentation:
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309


print( "\n***** enumerations *****" )
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145

// raw value types can be numeric (int, float, etc.), character or string.
enum SimpleEnum: Int
{
    case Value1, Value2, Value3
}

let simpleEnumValue = SimpleEnum.Value1
print( "enum value \(simpleEnumValue), raw value \(simpleEnumValue.rawValue)" )


// enums include support for computed properties and instance methods.
enum ClubStatus: Int
{
    case NotEnrolled = 1
    case Enrolled = 2
    case NewTermsOptional = 3
    case NewTermsRequired = 4
    case Inactive = 5
    case Declined = 6
    
    var label: String {
        switch self
        {
        case .NotEnrolled:
            return "Not Enrolled"
        case .Enrolled:
            return "Enrolled"
            // etc.
        default:
            return String( self.rawValue )
        }
    }
    
    func isActive() -> Bool
    {
        return self == .Enrolled ||
               self == .NewTermsOptional ||
               self == .NewTermsOptional
    }
}

let status = ClubStatus.Enrolled
print( "status raw value: \(status.rawValue), label: \(status.label)" )
print( "active: \(status.isActive())" )


// the cases in an enum are value types themselves. this makes
// easy to define a union in an enum.
enum Coordinate
{
    case Grid(Double, Double)
    case Space(Double, Double, Double)
}

let gridPoint = Coordinate.Grid(5.0, 5.0)
let pointInSpace = Coordinate.Space(3.0, 2.0, 4.0)

switch gridPoint
{
case .Grid( let x, let y ):
    print( "2D coordinate: \(x), \(y)" )

case .Space( let x, let y, let z ):
    print( "3D coordinate: \(x), \(y), \(z)" )
}


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
    print( "Full name is \(firstName) \(lastName)" )
}

// it is often less confusing to define the closure before calling the function
let fullNameHandler = { (firstName: String, lastName: String) -> Void in
    print( "Full name is \(firstName) \(lastName) [closure assigned to a constant]" )
}

getFullNameForUserId( "1234", completion: fullNameHandler )
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
// encapsulate a few relatively simple data values, otherwise
// use a class. 
//
// See Apple's docs for full explanation - "Choosing Between
// Classes and Structures" section
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html



// End of part 2 of 3
