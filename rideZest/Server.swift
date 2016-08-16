//
//  Server.swift
//  rideZest
//
//  Created by Ram Mareddy on 8/15/16.
//  Copyright © 2016 infiniteZest. All rights reserved.
//

import UIKit
import CoreLocation

class Server {
    
    /// Singleton for the server
    static let shared = Server()
    
    // ---------------------------------------------------------------------------------------------
    // MARK: Common JSON and image Fetching

    /**
     Common session used across different fetches and posts.
     */
    var session: NSURLSession {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        return session
    }
    
    /**
     Common/generic fetch request. This fetches the JSON from server and passes it to the calling
     method as a dictionary. The calling method will have to further process the objects in this
     dictionary into specific objects (like products, profile, etc.)
     */
    func fetchJSON(request: NSURLRequest, completionHandler: (jsonDictionary: [String: AnyObject]?)->Void) {
        
        let dataTask = session.dataTaskWithRequest(request) {(data, response, error) in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            guard let jsonData = data else {
                print("Empty data returned from request")
                return
            }
            
            do {
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? [String: AnyObject]
                print(jsonDictionary)
                completionHandler(jsonDictionary: jsonDictionary)
            } catch(let error) {
                print("Problem converting to array \(error)")
                return
            }
        }
        
        dataTask.resume()
    }

    /**
     Given series of name/value tuples, an array of NSURLQueryItem is returned. This can be used
     in the NSURLComponents class.
     */
    func prepareQueryItems(items: (name: String, value: String)...)->[NSURLQueryItem] {
        var queryItems = [NSURLQueryItem]()
        for (name, value) in items {
            let queryItem = NSURLQueryItem(name: name, value: value)
            queryItems.append(queryItem)
        }
        return queryItems
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: Profile API
    
    
    
    // ---------------------------------------------------------------------------------------------
    // MARK: Ride API
    
    
    
    
    // ---------------------------------------------------------------------------------------------
    // MARK: Product API
    
    /// Prepares a product request with server token as a header field and latitude and longitude
    /// of the current location as query strings.
    var productRequest: NSURLRequest {
        // Gets the current coordinate
        //let coordinate = CLLocation.init().coordinate
        
        // Gets the coordinates for San Francisco in Simulator
        let coordinate = CLLocationCoordinate2D(latitude: 37.7759792, longitude: -122.41823)
        
        let urlComponents = NSURLComponents(string: EndPoint.products.path)!
        urlComponents.queryItems = prepareQueryItems((name: "latitude", value: String(coordinate.latitude)),
                                                     (name: "longitude", value: String(coordinate.longitude)))
        
        print(urlComponents.URL!)
        let request = NSMutableURLRequest(URL: urlComponents.URL!)
        request.setValue("Token " + ServerStrings.shared.serverToken, forHTTPHeaderField: "Authorization")
        return request
    }
    
    /**
     Fetches the products by calling the common fetchJSON method. Plucks the products dictionary
     from the JSON dictionary and returns the products dictionary.
     */
    func fetchProducts(completionHandler: (productDictionary: [String: AnyObject]?)->Void) {
        fetchJSON(productRequest) {(jsonDictionary) in
            guard let jsonDictionary = jsonDictionary else {
                print("Empty JSON Dictionary")
                return
            }
            
            let productDictionary = jsonDictionary["products"] as? [String: AnyObject]
            completionHandler(productDictionary: productDictionary)
        }
    }
}