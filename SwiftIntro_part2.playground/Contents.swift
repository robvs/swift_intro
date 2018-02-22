//import UIKit
//
///*******************************************************************************
// Target audience is experienced developers who are not familiar with swift.
// This tutorial focuses more on some of the important concepts in swift than
// the syntax. It's easy enough to use reference materials for details on syntax.
//
// Part 2 of 3
// A quick tour of basic Swift syntax and language features.
//*/
//
//// For more complete details on any topic, see Apple's documentation:
//// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309
//
//
//print( "\n***** enumerations *****" )
//// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html#//apple_ref/doc/uid/TP40014097-CH12-ID145
//
//// raw value types can be numeric, character or string.
//enum SimpleEnum: Int
//{
//    case value1, value2, value3
//}
//
//
//let simpleEnumValue = SimpleEnum.value1
//print( "enum value \(simpleEnumValue), raw value \(simpleEnumValue.rawValue)" )
//
//
//// enums include support for computed properties and instance methods.
//enum ClubStatus: Int
//{
//    case notEnrolled = 1
//    case enrolled = 2
//    case newTermsOptional = 3
//    case newTermsRequired = 4
//    case inactive = 5
//    case declined = 6
//
//    var label: String {
//        switch self
//        {
//        case .notEnrolled:
//            return "Not Enrolled"
//        case .enrolled:
//            return "Enrolled"
//            // etc.
//        default:
//            return String( self.rawValue )
//        }
//    }
//
//    func isActive() -> Bool
//    {
//        return self == .enrolled ||
//               self == .newTermsOptional ||
//               self == .newTermsRequired
//    }
//}
//
//
//let status = ClubStatus.enrolled
//print( "status raw value: \(status.rawValue), label: \(status.label)" )
//print( "active: \(status.isActive())" )
//
//
//// cases in enums can have 'associated values' and each case can have different
//// associated types - similar to unions and variants in other languages.
//enum Coordinate
//{
//    case grid(Double, Double)
//    case space(Double, Double, Double)
//}
//
//let gridPoint: Coordinate = Coordinate.grid(5.0, 5.0)
//let pointInSpace: Coordinate = Coordinate.space(3.0, 2.0, 4.0)
//
//
//switch gridPoint
//{
//case .grid( let x, let y ):
//    print( "2D coordinate: \(x), \(y)" )
//
//case .space( let x, let y, let z ):
//    print( "3D coordinate: \(x), \(y), \(z)" )
//}
//
//
//print( "\n***** closures *****" )
//// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94
//
//// closures are self-contained blocks of functionality that
//// can be passed around. they are often used as a completion
//// parameter in asyncronous functions.
////
//// notice the syntax is very similar to defining a function.
//func getFullName( for userId: String,
//                  completion: (_ first: String, _ last: String) -> Void )
//{
//    // executing the completion closure is exactly like calling a function,
//    // but without named parameters.
//    completion( "Amy", "Pond" )
//}
//
//// supplying a closure as a method prameter looks like this...
//// notice that the closure parameter types are inferred here because
//// the compiler knows the `completion` parameter's type.
//
//getFullName( for: "1234", completion: { (firstName, lastName) -> Void in
//    print( "Full name is \(firstName) \(lastName)" )
//})
//
//// or if a closure is the last parameter of a function, it can be
//// written as a 'trailing closure' where it is written outside
//// of the function's closing parentheses.
//getFullName( for: "1234" ) { (firstName, lastName) -> Void in
//
//    print( "Full name is \(firstName) \(lastName)" )
//}
//
//
//// it is often less confusing to define the closure before calling the function.
//// notice that the closure parameter types are not inferred here because the
//// compiler does not know the type of `fullNameHandler`
//let fullNameHandler = { (firstName: String, lastName: String) -> Void in
//    
//    print( "Full name is \(firstName) \(lastName) [closure assigned to a constant]" )
//}
//
//getFullNameForUserId( "1234", completion: fullNameHandler )
//
//
//print( "\n***** classes & structures *****" )
//// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82
//
//// defining and instantiating a class is very similar to other modern languages
//class Person
//{
//    // properties
//    var firstName: String
//    var lastName: String
//
//    // initializers
//    init( firstName: String, lastName: String)
//    {
//        self.firstName = firstName
//        self.lastName = lastName
//    }
//
//    // instance methods go here...
//}
//
//var person = Person( firstName: "Rose", lastName: "Tylor" )
//print( "Person frist name is \(person.firstName)" )
//
//
//// Swift structs can do much of what classes can do including
//// encapsulation of properties and methods as well as implement
//// protocols. but structs do not allow inheritance and are
//// passed by value, not reference.
//struct User
//{
//    // properties
//    var firstName: String
//    var lastName: String
//
//    // functions
//    func fullName() -> String
//    {
//        return "\(firstName) \(lastName)"
//    }
//}
//
//
//// structs have an automatically-generated memberwise initializer.
//var user = User( firstName: "Rose", lastName: "Tylor" )
//print( "User frist name is \(user.firstName)" )
//
//// Guidelines: Prefer struct over class when the primary purpose is to
//// encapsulate a few relatively simple data values, otherwise use a class.
////
//// See Apple's docs for full explanation - "Choosing Between
//// Classes and Structures" section
//// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html
//
//
//// This material can be found on GitHub at https://github.com/robvs/swift_intro
//
//// End of part 2 of 3
//
