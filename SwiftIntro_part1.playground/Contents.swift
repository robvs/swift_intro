import AVFoundation
import UIKit

/*******************************************************************************
 This presentation is an introduction to Swift that focuses on some of Swift's
 more interesting features (i.e. cool things you can do with enumerations and
 switch statements, etc.), while only briefly touching on its basic syntax 
 (it's easy enough to use reference materials for details on basic syntax).

 The target audience is experienced developers who are not familiar with swift.

 This presentation can be found on GitHub at https://github.com/robvs/swift_intro

 Part 1 of 3
 A quick tour of basic Swift syntax and language features.
*/

// For more complete details on any topic, see Apple's documentation:
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309


print( "***** swift playgrounds *****" )

// This is a Swift playgound. It's an interactive coding environment that
// evaluates each statement and displays results as updates are made,
// without the need to create a project.
//
// The pane to the right shows results in-line, and the pane on the bottom
// is a debug area.


print( "\n***** let and var *****" )

// declaring constants and variables
// let is preferred unless you expect to change its value.
let pi:            Double = 3.14159
var diameter:      Double = 5
var circumference: Double

circumference = diameter * pi
diameter      = 10
circumference = diameter * pi

// notice there are no semicolons. they're allowed, but discouraged.
// they exist so that you can put mutiple statements on a single line.


// with let, struct types are immutable but class instances are not.
// arrays and dictionaries are struct types.
var mutableNames: [String] = ["Fred", "Wilma"]
let names:        [String] = ["Fred", "Wilma"]

mutableNames[0] = "Barney"
//names[0]      = "Barney"


class Names
{
    var name1:String = "Fred"
    var name2:String = "Wilma"
}

let namesObj: Names = Names()
namesObj.name1 = "Barney"


// constants and variable names can contain almost any character,
// including unicode. i can't recommend using symblols like this
// in your code, but it's there if you want it.
let 🐶: String   = "dog"
let 🐮: String   = "cow"
let 🐶🐮: String = 🐶 + 🐮


// type conversions must be explicit
let intValue:       Int    = 10
let doubleValue:    Double = Double(intValue)

//let badDoubleValue: Double = intValue


// type inference
let pie = "apple pie"
let pi_ = 3.14159


// string formatting - use \()
print( "A circle w/dia of \(diameter) has a circ of \(circumference)" )
print( "\(🐶🐮) says 'moof'")


print( "\n***** functions *****" )

// parameters must be named. return type syntax is a bit different.
func greetingForName( firstName: String, lastName: String ) -> String
{
    return "Hello \(firstName) \(lastName)"
}

// when calling a function, the first param is not named, but all remaining
// params include the name
let greeting: String = greetingForName( "Amy", lastName: "Pond" )
print( greeting )


print( "\n***** tuples *****" )

// tuples group multiple values into a single compound value.
// in some ways similar to annonymous classes in C#.
let firstAndLastName: (String, String) = ("Rose", "Tyler")
print( firstAndLastName.0 )
print( firstAndLastName.1 )


// there may be some limited use cases where referencing values in
// a tuple by index is warranted, but most of the time you'll want
// to use a named tuple where each value has a corresponding name.


func fullNameForUserId( userId: String ) -> (first: String,
                                             middle: String,
                                             last: String)
{
    // names are optional
    return (first: "Amy", middle: "Jessica", last: "Pond")
//    return ("Amy", "Jessica", "Pond")
}

let fullName = fullNameForUserId( "asdf" )
fullName.first
fullName.0
print( fullName )


print( "\n***** for Loops and Ranges *****" )

// loop on a range of values
for i in 0...4
{
    print( "i is \(i)" )
}

// there's also syntax for half-open range if you don't want to include the
// final value
let simpleArray = ["zero", "one", "two"]
//for index in simpleArray.indices
for index in 0..<simpleArray.count
{
    print( "simpleArray item at index \(index): \(simpleArray[index])" )
}

// another way to write this
for index in simpleArray.indices
{
    print( "simpleArray item at index \(index): \(simpleArray[index])" )
}


// as with most modern languages, swift allows you to iterate over the
// values in a collection.
let teamMemberNames = ["matt", "mitch", "kraig", "Jim"]
for name in teamMemberNames
{
    print( "Team member: \(name)" )
}

// for times that you need both index and sequence element, the
// enumerate function provides a tuple of index and element.
for ( index, name ) in teamMemberNames.enumerate() {
    print( index )
    print( name )
}


// c-style for loop
for ( var i = 0; i < 10; i++ )
{
    print( i )
}

// i++ and ++i is deprecated
// this for loop syntax is deprecated as of Swift 2.2
// here is the proposal that inspired this:
//   https://github.com/apple/swift-evolution/blob/master/proposals/0007-remove-c-style-for-loops.md


print( "\n***** Optionals *****" )

// optional values (aka nullable)
// Unless explicitly declared as optional, values can not be set to null.

// By being deliberate about declaring a value as optional, Swift is able
// to catch many nil pointer errors at compile time instead of run time.

//var badName: String = nil
var name: String? = nil

name = "Amy Pond"

if name != nil
{
    // optionals must be "unwrapped" before they can be used.
    print( "Hello \(name!)" )
}


// a more convenient way to unwrap is with "optional binding".
// which is much preffered over forced unwrapping.
if let unwrappedName = name
{
    print( "Hello \(unwrappedName)" )
}
else
{
    print( "Name is nil" )
}

// "shadowing" enables the unwrapped value to have the name as the
// optional value
if let name = name
{
    print( "Hello \(name)" )
}


print( "\n***** the Pyramid of Doom *****" )

// unwrapping a group of obtional values
// (notice that basice types can be declared as optional)
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


// this can be rewritten using a shorthand syntax, which looks much better.
if let a = a, b = b, c = c
{
    print( "a + b + c = \(a + b + c)" )
}


print( "\n***** using guard to bail early *****" )
/**
Also see "When (not) to use guard" - http://radex.io/swift/guard/
*/

// guards can be handy in functions with optional parameters and you want
// do ealy error checking.
func addTwoOptionalValues( x: Int?, y: Int? ) -> Void
{
    guard let x = x else {
        print( "An 'x' value is required" )
        return
    }
    let y = y ?? 4
    
    // at this point, x and y are unwrapped and we know that all have
    // valid values
    
    print( "x + y = \(x + y)" )
}


// test it...
addTwoOptionalValues( a, y: b )
addTwoOptionalValues( a, y: nil )


print( "\n***** switch *****" )

// switch statement can match on numbers and strings.
// no need for break.
// switch statements must be exhaustive.
var preset: String = AVAssetExportPreset1920x1080
var height: Int

switch preset
{
case AVAssetExportPreset1920x1080:
    height = 1080
case AVAssetExportPreset1280x720:
    height = 720
case AVAssetExportPreset640x480:
    height = 480
default:
    height = 0
}

print( "preset height: \(height)" )


// since case statements don't automatically fall through, you
// can match multiple values by separating them with a comma.
switch preset
{
case AVAssetExportPreset1920x1080, AVAssetExportPresetHighestQuality:
    height = 1080
case AVAssetExportPreset1280x720, AVAssetExportPresetMediumQuality:
    height = 720
case AVAssetExportPreset640x480, AVAssetExportPresetLowQuality:
    height = 480
default:
    height = 0
}

print( "preset height: \(height)" )


// values in a switch can also match on logic statements & intervals.
switch height
{
case let h where h >= 1080:
    preset = AVAssetExportPreset1920x1080
case 720..<1080:
    preset = AVAssetExportPreset1280x720
case 480..<720:
    preset = AVAssetExportPreset640x480
default:
    preset = AVAssetExportPresetLowQuality
}

print( "preset: \(preset)" )


// End of part 1 of 3
