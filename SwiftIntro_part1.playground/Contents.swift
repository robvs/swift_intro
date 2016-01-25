import UIKit

/*******************************************************************************
 Target audience is experienced developers who are not familiar with swift.
 This tutorial focuses more on some of the important concepts in swift than
 the syntax. It's easy enough to use reference materials for details on syntax.

 This material can be found on GitHub at https://github.com/robvs/swift_intro

 Part 1 of 3
 A quick tour of basic Swift syntax and language features.
*/

// For more complete details on any topic, see Apple's documentation:
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309

// This is a Swift playgound. It's an interactive coding environment that
// evaluates each statement and displays results as updates are made,
// without the need to create a project.


print( "***** let and var *****" )

// declaring constants and variables
// use let by default, use var only when you expect the value to change.
let pi:            Double = 3.14159
var diameter:      Double = 5
var circumference: Double

circumference = diameter * pi
diameter      = 10
circumference = diameter * pi

// notice there are no semicolons. they're allowed, but discouraged.
// they exist so that you can put mutiple statements on a single line.


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

// constants and variable names can contain almost any character, 
// including unicode. i can't recommend using symblols like this
// in your code, but it's there if you want it.
let 🐶🐮 = "dogcow"
print( "\(🐶🐮) says, \"moof\"")


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

// parameters must be named. return type syntax is a little odd.
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
let firstAndLastName: (String, String) = ("Rose", "Tyler")
print( firstAndLastName.0 )
print( firstAndLastName.1 )

// there may be some limited use cases where referencing values
// in a tuple by index is warranted, but most of the time you'll
// want to use a named tuple.


// named touples, where each value in the tuple has a corresponding name.
func fullNameForUserId( userId: String ) -> (first: String, middle: String, last: String)
{
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
    let outputStr = "i is \(i)"
    print( outputStr )
}

// syntax for half-open range if you don't want to include the final value
let simpleArray = ["zero", "one", "two"]
for index in 0..<simpleArray.count
{
    print( "simpleArray item at index \(index): \(simpleArray[index])" )
}

// for time where you want to simply iterate over the values in a collection,
// as with other modern languages, Swift can do that too.
let teamMemberNames = ["matt", "mitch", "kraig", "Jim"]
for name in teamMemberNames
{
    print( "Team member: \(name)" )
}


print( "\n***** Optionals *****" )

// optional values (aka nullable)
// Unless explicitly declared as optional, values can not be set to null.
//var badName: String = nil
var name: String? = nil

// By being  deliberate about declaring a value as optional, Swift is able
// to catch many nil pointer errors at compile time instead of run time.
name = "Amy Pond"

if name != nil
{
    // optionals must be "unwrapped" before they can be used.
    print( "Hello \(name!)" )
}

// a more convenient way to unwrap is with "optional binding".
// this is preffered over forced unwrapping.
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


print( "\n***** optionals and the Pyramid of Doom *****" )
/**
 Also see "When (not) to use guard" - http://radex.io/swift/guard/
*/

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

// this can be rewritten using a shorthand syntax
if let a = a, b = b, c = c
{
    print( "a + b + c = \(a + b + c)" )
}


print( "\n***** using guard to bail early *****" )

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

