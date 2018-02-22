import Foundation


/**
 Get the user id from a url path.
 */
public func getUserId( from url: URL ) -> String?
{
    let urlElements = url.path.split(separator: "/")
    guard let userIdSubstring = urlElements.last else {
        return nil
    }
    
    return String(userIdSubstring)
}


/**
Replacement for NSURLSession.sharedSession().dataTaskWithRequest(request) used to
simplify the sample code.
*/
public func simpleDataTaskWithRequest(
    request: NSURLRequest,
    completionHandler: ([String : AnyObject]?) -> Void )
{
    // quick and dirty unwrapping
    let userId = getUserId( from: request.url! )
    
    if let userId = userId, userId == "1234"
    {
        let response = ["firstName": "Real", "lastName": "Service Request"] as [String : AnyObject]
        completionHandler( response )
    }
    else
    {
        completionHandler( nil )
    }
}
