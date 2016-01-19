import Foundation


/**
 Get the user id from a url path.
 */
public func userIdFromUrl( url: NSURL ) -> String?
{
    if let urlPath = url.path
    {
        let substringStart = urlPath.startIndex.advancedBy(6)
        let userId = urlPath.substringFromIndex(substringStart)
        return userId
    }
    else
    {
        return nil
    }
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
    let userId = userIdFromUrl( request.URL! )
    
    if userId == "1234"
    {
        let response = ["firstName": "Real", "lastName": "Service Request"]
        completionHandler( response )
    }
    else
    {
        completionHandler( nil )
    }
}
