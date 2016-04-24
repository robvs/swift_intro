import AVFoundation
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

// raw value types can be numeric, character or string.
enum VideoPresetSimple: Int
{
    case _1080p, _720p, _480p
}

let simplePreset = VideoPresetSimple._1080p
print( "enum value \(simplePreset), raw value \(simplePreset.rawValue)" )


// enums include support for computed properties and instance methods.
// notice how this helps reduce the need for related helper functions.
enum VideoPreset: Int
{
    case _1080p = 1
    case _720p  = 2
    case _480p  = 3
    
    var height: Int {
        // notice that since we're already in the enum's context, shortend dot syntax
        // can be used (the VideoPreset prefix is not needed).
        switch self
        {
        case ._1080p:
            return 1080
        case ._720p:
            return 720
        case ._480p:
            return 480
        }
    }
    
    func isHighDef() -> Bool
    {
        return self.height >= 720
    }
}

let preset = VideoPreset._1080p
print( "preset height: \(preset.height)")
print( "preset is high-def: \(preset.isHighDef())")


// enums support extensions.
// here, we're adding a new calculated property to the VideoPreset enum.
extension VideoPreset {
    var avAssetPreset: String {
        switch self
        {
        case ._1080p:
            return AVAssetExportPreset1920x1080
        case ._720p:
            return AVAssetExportPreset1280x720
        case ._480p:
            return AVAssetExportPreset640x480
        }
    }
}

print( "preset av preset: \(preset.avAssetPreset)")


// enums support initializers for defining a default value.
extension VideoPreset {
    init()
    {
        self = ._720p
    }
}

let defaultPreset = VideoPreset()
print( "defult preset: \(defaultPreset)" )


// at this point our enum is starting to look a lot like a class, which
// is a good thing. with swift there can be many situations where an
// enum or struct can be used instead of a class. i'll leave determining
// when it's better to not use a class up to the reader.


// cases in enums can have 'associated values' and each case can have different
// associated types - similar to unions and variants in other languages.
enum Coordinate
{
    case grid(Double, Double)
    case space(Double, Double, Double)
}

let gridPoint:    Coordinate = Coordinate.grid(5.0, 5.0)
let pointInSpace: Coordinate = Coordinate.space(3.0, 2.0, 4.0)


// this shows the syntax used for switching on an enum that uses associated values.
switch gridPoint
{
// this is a short-hand way of writing: case .grid( let x, let y ):
case let .grid( x, y ):
    print( "2D coordinate: \(x), \(y)" )

case let .space( x, y, z ):
    print( "3D coordinate: \(x), \(y), \(z)" )
}


print( "\n***** closures *****" )
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94

// closures are self-contained blocks of functionality that
// can be passed around. they are often used as a completion
// parameter in asyncronous functions.
//
// notice the syntax is very similar to defining a function.
func getFullName( for userId: String,
                  completion: (_ first: String, _ last: String) -> Void )
{
    // executing the completion closure is exactly like calling a function,
    // but without named parameters.
    completion( "Amy", "Pond" )
}

// supplying a closure as a method prameter looks like this...
// notice that the closure parameter types are inferred here because
// the compiler knows the `completion` parameter's type.

getFullName( for: "1234", completion: { (firstName, lastName) -> Void in
    print( "Full name is \(firstName) \(lastName)" )
})

// or if a closure is the last parameter of a function, it can be
// written as a 'trailing closure' where it is written outside
// of the function's closing parentheses.
getFullName( for: "1234" ) { (firstName, lastName) -> Void in

    print( "Full name is \(firstName) \(lastName)" )
}


// it is often less confusing to define the closure before calling the function.
// notice that the closure parameter types are not inferred here because the
// compiler does not know the type of `fullNameHandler`
let fullNameHandler = { (firstName: String, lastName: String) -> Void in
    
    print( "Full name is \(firstName) \(lastName) [closure assigned to a constant]" )
}

getFullName( for: "1234", completion: fullNameHandler )


print( "\n***** classes & structures *****" )
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82

// defining and instantiating a class is very similar to other modern languages
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

    // instance methods go here...
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

// Guidelines: Prefer struct over class when the primary purpose is to
// encapsulate a few relatively simple data values, otherwise use a class.
//
// See Apple's docs for full explanation - "Choosing Between
// Classes and Structures" section
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html


// This material can be found on GitHub at https://github.com/robvs/swift_intro

// End of part 2 of 3
