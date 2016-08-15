//
//  ServerStrings.swift
//  rideZest
//
//  Created by Ram Mareddy on 8/15/16.
//  Copyright © 2016 infiniteZest. All rights reserved.
//

import Foundation

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