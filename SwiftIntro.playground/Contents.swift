import UIKit

/*******************************************************************************
 Target audience is experienced developers who are not familiar with swift.
 This tutorial focuses more on some of the important concepts in swift than
 the syntax. It's easy enough to use reference materials for details on syntax.

 Part 1 of 3
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


// type conversions must be explicit
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
//var badName: String = nil
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
func fullNameForUserId( userId: String ) -> (first: String, last: String)
{
    return ("Amy", "Pond")
}

let fullName = fullNameForUserId( "asdf" )
fullName.first
fullName.0
print( fullName )


// End of part 1 of 3

