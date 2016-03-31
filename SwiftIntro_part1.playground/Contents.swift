import UIKit

/*******************************************************************************
 This presentation is an introduction to Swift that focuses on some of Swift's
 more interesting features (i.e. closures, protocols, and cool things you can
 do with switch statements and enumerations), while only briefly touching on
 its basic syntax (it's easy enough to use reference materials for details on
 basic syntax).

 The target audience is experienced developers who are not familiar with swift.

 This presentation can be found on GitHub at https://github.com/robvs/swift_intro

 When presenting this material, it is recommended to comment-out the entire
 file, then uncomment short blocks in turn as the code is discussed. Also
 display the Debug area so that the audience can view results that aren't shown
 in the pane on the right.

 Part 1 of 3
 A quick tour of basic Swift syntax and language features.
*/

// For more complete details on any topic, see Apple's documentation:
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309


// This is a Swift playgound. It's an interactive coding environment that
// evaluates each statement and displays results as updates are made,
// without the need to create a project.
//
// The pane to the right shows results in-line, and the pane on the bottom
// is a debug area.


print( "***** let and var *****" )

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


print( "\n***** functions *****" )

// parameters must be named. return type syntax is a bit different.
// an argument label (i.e. `withFirstName` can be specified to help
// with readability when calling it.
func getGreeting( withFirstName firstName: String, lastName: String ) -> String
{
    return "Hello \(firstName) \(lastName)"
}

let greeting: String = getGreeting( withFirstName: "Amy", lastName: "Pond" )
print( greeting )


// use an underscore character as the argument label to indicate that no
// rgument label should be used when calling
func concatenate(_ text1: String, _ text2: String) -> String {
    return text1 + text2
}

let concatenatedText = concatenate("first", "last")
print( concatenatedText )


print( "\n***** tuples *****" )

// tuples group multiple values into a single compound value.
// similar, in some ways, to annonymous classes in C#.
let firstAndLastName: (String, String) = ("Rose", "Tyler")
print( firstAndLastName.0 )
print( firstAndLastName.1 )

// there may be some limited use cases where referencing values in
// a tuple by index is warranted, but most of the time you'll want
// to use a named tuple where each value has a corresponding name.
func getFullName( for userId: String ) -> (first: String,
    middle: String,
    last: String)
{
    return (first: "Amy", middle: "Jessica", last: "Pond")
//    return ("Amy", "Jessica", "Pond")
}

let userId = "asdf"
let fullName = getFullName( for: userId )
fullName.first
fullName.0
print( fullName )


print( "\n***** for Loops and Ranges *****" )

// loop on a range of values
for i in 0...4
{
    print( "i is \(i)" )
}


// syntax for half-open range if you don't want to include the final value
let simpleArray = ["zero", "one", "two"]
for index in 0..<simpleArray.count
{
    print( "simpleArray item at index \(index): \(simpleArray[index])" )
}


// for times where you want to simply iterate over the values in a collection,
// as with other modern languages, Swift can do that too.
let teamMemberNames = ["matt", "mitch", "kraig", "Jim"]
for name in teamMemberNames
{
    print( "Team member: \(name)" )
}


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
if let a = a, let b = b, let c = c
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
    guard let y = y else {
        print( "A 'y' value is required" )
        return
    }

    // at this point, x and y are unwrapped and we know that all have
    // valid values

    print( "x + y = \(x + y)" )
}


// test it...
addTwoOptionalValues( x: a, y: b )
addTwoOptionalValues( x: a, y: nil )


print( "\n***** switch *****" )

// no need for break
// can match on strings & logic statements
// switch statements must be exhaustive
let phoneNumber = "616-555-1212"

switch phoneNumber
{
case "616-555-1234":
    print( "Marge's number" )

case "616-555-4321":
    print( "Sandy's number" )

case let localNumber where localNumber.hasPrefix("616"):
    print( "\(localNumber) is an unknown local number" )

default:
    print( "\(phoneNumber) is out of the area" )
}


// since case statements don't automatically fall through, you
// can match multiple values by separating them with a comma.
var someNumber = 1

switch someNumber
{
case 1, 2, 3:
    print( "someNumber is 1, 2 or 3" )
case 4, 5:
    print( "someNumber is 4 or 5" )
default:
    print( "this is not the number you're looking for" )
}


// values in a switch can also match on intervals.
someNumber = 42

switch someNumber
{
case 0:
    print( "zero" )
case 1..<25:
    print( "1 to 24" )
case 25..<50:
    print( "25 to 49" )
default:
    print( "50 or more" )
}



// End of part 1 of 3
