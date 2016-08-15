//
//  ServerStrings.swift
//  rideZest
//
//  Created by Ram Mareddy on 8/15/16.
//  Copyright © 2016 infiniteZest. All rights reserved.
//

import Foundation

/// Base URL string for OAuth 2.0 access
let baseOAuthURLString = "https://login.uber.com/oauth/v2"
/// Base URL for the Uber API
let baseAPIURLString = "https://api.uber.com"

/**
 Provides the full path of URL string for various OAuth and API calls.
 */
enum EndPoint {
    /// Endpoints for OAuth 2.0
    case authorize, token
    /// Endpoints for fetching information for various items.
    case profile, rides, products
    
    /**
     Provides the full access path for a given end point.
     */
    func path() -> String {
        switch(self) {
        case .authorize:
            return baseOAuthURLString+"/authorize"
        case .token:
            return baseOAuthURLString + "/token"
        case .profile:
            return baseAPIURLString + "/v1/me"
        case .rides:
            return baseAPIURLString + "/v1.2/history"
        case .products:
            return baseAPIURLString + "/v1/products"
        }
    }
}

/**
 Important strings for accessing server are available from the singleton.
 */
class ServerStrings {
    
    /// Singleton for accessing the important strings for accessing the server.
    static let shared = ServerStrings()
    
    // ---------------------------------------------------------------------------------------------
    // MARK: Authentication Strings
    
    /// Client Id provided by Uber during registration.
    let clientId = "vS8oEUcwWlwBXVBYtlCd2mHseYKzGlJD"
    /// Client Secret provided by Uber during registration.
    let clientSecret = "i8N1whPF7WAfmwTTaedWdR53Oj_LqFwf03INGcIg"
    
    /// Server token can be used in calls where bearer token from OAuth is not necessary.
    /// This can be used in calls like getting the Product listing, where OAuth is not necessary.
    let serverToken = "Z1qzARfECxHzO1PE7S53VQr_Eh23n5_srbp1bEpt"
}