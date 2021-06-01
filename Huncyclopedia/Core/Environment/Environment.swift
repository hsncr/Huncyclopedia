//
//  Envionment.swift
//  Core
//
//  Created by hsncr on 30.11.2020.
//

import Foundation

public struct Environment {
    
    public static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        
        return dict
    }()
    
    
    public static let bundleName: String = {
        
        guard let value = Environment.infoDictionary["CFBundleName"] as? String else {
            fatalError("CFBundleName not set in plist for this environment")
        }
        
        return value
    }()
    
    static let bundleID: String = {
        
        guard let value = Environment.infoDictionary["CFBundleIdentifier"] as? String else {
            fatalError("CFBundleIdentifier not set in plist for this environment")
        }
        
        return value
    }()
    
    public static let buildNumber: Int = {
        
        guard let bundleVersion = Environment.infoDictionary["CFBundleVersion"] as? String,
              let version = Int(bundleVersion) else {
            return 0
        }
        
        return  version
    }()
}
