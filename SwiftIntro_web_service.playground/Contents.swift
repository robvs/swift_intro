import Foundation

// Target audience is experienced developers who are not familiar with swift.
// Protocol Oriented Programming - this demo is just the tip of the iceberg

// Get mPerks user info response:
//
// {
//     "firstName":"Amy","lastName":"Pond"
// }

// swift representation of the user info as a dictionary
let sampleUserInfo: Dictionary = ["firstName": "Amy", "LastName": "Pond"]


/**
 Define a json web services class that performs a GET and returns a JSON dictionary.
*/
class SimpleJsonService
{
	// Perform a Get on a specified url.
    // Notice that completion is a closure with two params - response and error.
    func Get( url: NSURL,
              completion: (response: [String : AnyObject]?, error: NSError?) -> Void )
    {
        let request = NSMutableURLRequest( URL: url )
        
        simpleDataTaskWithRequest(request) { (response) -> Void in
            if let response = response
            {
                // success
                completion( response: response, error: nil )
            }
            else
            {
                // failure
                let userInfo = [NSLocalizedDescriptionKey: "Invalid user ID"]
                let responseError = NSError( domain: "JSONService",
                                             code: 9,
                                             userInfo: userInfo )
                completion( response: nil, error: responseError )
            }
        }
    }
}

/**
 Define a class that would be used w/in the app to retrive user 
 profile information.
*/
class SimpleUserProfileService
{
    let jsonService: SimpleJsonService
    
    init()
    {
        self.jsonService = SimpleJsonService()
    }
    
    // use the json service instance to retrieve the user's full name
    func getFullNameForUserId(
        	userId: String,
        	completion: (name: (first: String, last: String)?, error: NSError?) -> Void )
    {
        let url = NSURL( string: "http://api.sample.com/user/\(userId)" )!
        
        jsonService.Get( url ) { (response, error) -> Void in
            // use guard to unwrap response and return early if there
            // was an error. use swift's support for "shadowing" to 
            // reuse 'response'
            guard let response = response else {
                print( "There was an error: \(error)" )
                return
            }
            
            // the response is looking good, let's grab the data that 
            // we're after.
            let firstName = response["firstName"] as? String
            let lastName = response["lastName"] as? String
            if firstName != nil && lastName != nil
            {
                completion( name: (firstName!, lastName!), error: nil )
            }
            else
            {
                // bad data
                let dataError = NSError( domain: "MPerksService", code: 9, userInfo: nil )
                completion( name: nil, error: dataError )
            }
    	}
    }
}


print( "***** Calling the user profile service *****" )
/**
 This is how we'd retrieve user profile info from w/in the app.
*/
let simpleUserProfileService = SimpleUserProfileService()
simpleUserProfileService.getFullNameForUserId( "1234" ) { (name, error) -> Void in
    guard let name = name else {
        print( "There was an error: \(error)" )
        return
    }
    
    print( "Name is \(name.first) \(name.last)" )
}


print( "\n-- clean up response closure --" )
// clean up the response closure by defining a function who's
// signature matches the closure's signature.
func handleUserProfileServiceResponse( name: (first: String, last: String)?,
                                       error: NSError? )
{
    guard let name = name else {
        print( "There was an error: \(error)" )
        return
    }
    
    print( "Name is \(name.first) \(name.last)" )
}

simpleUserProfileService.getFullNameForUserId(
    "1234",
    completion: handleUserProfileServiceResponse )


// how do we test getFullNameForUserId()?

// try a different user id
simpleUserProfileService.getFullNameForUserId(
    "4321",
    completion: handleUserProfileServiceResponse )

// try some more user ids...


// there's a big problem with this type of testing - it relies on
// the json service responses never changing, resulting in brittle
// tests. it would be much better to mock or fake the json service
// responses so that we can focus on just the code that we've written.

// one way to solve this problem is through protocols and 
// dependency injection.


print( "\n***** Protocols and dependency injection *****" )
/**
 Create a protocol for the json service and redifine the
 class to conform to the protocol.
 */
protocol JsonServiceProtocol
{
    func Get( url: NSURL,
              completion: (response: [String: AnyObject]?, error: NSError?) -> Void )
}

class JsonService: JsonServiceProtocol
{
    func Get( url: NSURL,
              completion: (response: [String : AnyObject]?, error: NSError?) -> Void)
    {
        let request = NSMutableURLRequest(URL: url)
        
        simpleDataTaskWithRequest(request) { (serviceResponse) -> Void in
            if let goodResponse = serviceResponse
            {
                // success
                completion( response: goodResponse, error: nil )
            }
            else
            {
                // failure
                let responseError = NSError(domain: "MPerksService", code: 9, userInfo: nil)
                completion( response: nil, error: responseError )
            }
        }
    }
}

// Modify the user profile service class to reference the protocol
// instead of the concrete json service class, and inject an instance
// via the initializer.
class UserProfileService
{
    let jsonService: JsonServiceProtocol
    
    init( jsonService: JsonServiceProtocol )
    {
        self.jsonService = jsonService
    }
    
    // use the json service instance to retrieve the user's full name
    func getFullNameForUserId(
        	userId: String,
        	completion: (name: (first: String, last: String)?, error: NSError?) -> Void )
    {
        let url = NSURL( string: "http://api.sample.com/user/\(userId)" )!
        
        jsonService.Get( url ) { (response, error) -> Void in
            guard let response = response else {
                print( "There was an error: \(error)" )
                return
            }
            
            let firstName = response["firstName"] as? String
            let lastName = response["lastName"] as? String
            if firstName != nil && lastName != nil
            {
                completion( name: (firstName!, lastName!), error: nil )
            }
            else
            {
                // bad data
                let dataError = NSError( domain: "MPerksService", code: 9, userInfo: nil )
                completion( name: nil, error: dataError )
            }
        }
    }
}

// Now we can test the user profile service using a fake json 
// service instance.
class FakeJsonService: JsonServiceProtocol
{
    func Get(url: NSURL, completion: (response: [String : AnyObject]?, error: NSError?) -> Void)
    {
        var serviceResponse = [String: String]()
        let userId = userIdFromUrl( url )
        
        switch userId!
        {
        case "1234":
            serviceResponse = ["firstName": "Rose", "lastName": "Tyler"]
        case "4321":
            serviceResponse = ["firstName": "Amy", "lastName": "Pond"]
        default:
            serviceResponse = ["firstName": "not", "lastName": "found"]
        }
        
        completion( response: serviceResponse, error: nil )
    }
}

print( "\n-- test UserProfileService using fake json service --" )
var userProfileService = UserProfileService( jsonService: FakeJsonService() )

userProfileService.getFullNameForUserId( "1234" ) { (name, error) -> Void in
    handleUserProfileServiceResponse( name, error: error )
}

userProfileService.getFullNameForUserId( "4321" ) { (name, error) -> Void in
    handleUserProfileServiceResponse( name, error: error )
}

userProfileService.getFullNameForUserId( "asdf" ) { (name, error) -> Void in
    handleUserProfileServiceResponse( name, error: error )
}


print( "\n***** Protocols Extensions *****" )
/**
 Create an extension that adds a Get() overload that includes
 a timeout parameter.
 
 Protocol Extensions can be especially useful for extending types
 who's implementation you don't own.
*/
extension JsonServiceProtocol
{
    // Overload Get() by adding a timeout param.
    func Get( url: NSURL,
              timeout: NSTimeInterval,
              completion: (response: [String : AnyObject]?, error: NSError?) -> Void )
    {
        let request = NSMutableURLRequest( URL: url,
                                           cachePolicy: .UseProtocolCachePolicy,
                                           timeoutInterval: timeout )
        
        simpleDataTaskWithRequest(request) { (response) -> Void in
            if let response = response
            {
                // success
                completion( response: response, error: nil )
            }
            else
            {
                // failure
                let userInfo = [NSLocalizedDescriptionKey: "Invalid user ID"]
                let responseError = NSError( domain: "JSONService",
                    code: 9,
                    userInfo: userInfo )
                completion( response: nil, error: responseError )
            }
        }
    }
}

// now extend the user profile service class to make use of
// the protocol extension.
extension UserProfileService
{
    func getFullNameForUserId(
            userId: String,
            timeout: NSTimeInterval,
            completion: (name: (first: String, last: String)?, error: NSError?) -> Void )
    {
        let url = NSURL( string: "http://api.sample.com/user/\(userId)" )!
        
        jsonService.Get( url, timeout: 1.0 ) { (response, error) -> Void in
            guard let response = response else {
                print( "There was an error: \(error)" )
                return
            }
            
            let firstName = response["firstName"] as? String
            let lastName = response["lastName"] as? String
            if firstName != nil && lastName != nil
            {
                completion( name: (firstName!, lastName!), error: nil )
            }
            else
            {
                // bad data
                let dataError = NSError( domain: "MPerksService", code: 9, userInfo: nil )
                completion( name: nil, error: dataError )
            }
        }
    }
}

// call the new "extended" function.
var userProfileServiceExt = UserProfileService( jsonService: JsonService() )
userProfileServiceExt.getFullNameForUserId( "1234", timeout: 1.0 ) { (name, error) -> Void in
    handleUserProfileServiceResponse( name, error: error )
}

