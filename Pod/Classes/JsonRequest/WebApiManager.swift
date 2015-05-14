//
//  WebApiUrlManager.swift
//  objectmapperTest
//
//  Created by Alex Bechmann on 29/04/2015.
//  Copyright (c) 2015 Alex Bechmann. All rights reserved.
//

import UIKit

private let kKey = CompresJSON.sharedInstance().settings.encryptionKey

public class WebApiManager: NSObject {
   
    public var domain: String?
    public var restKey: String?
    //var webApiManagerDelegate: WebApiManagerDelegate?
    
    //temp for compresjson
    public var encryptComponents = false
    
    public func setupUrlsForREST(restKey: String, overrideDomain: String?) -> WebApiManager {
        
        self.domain = overrideDomain
        self.restKey = restKey
        
        return self
    }
    
    public func setupUrlsForREST(key: String) -> WebApiManager {
        
        return setupUrlsForREST(key, overrideDomain: nil)
    }
    
    private func getDomain() -> String{
        
        var domain = ""
        
        if let d = WebApiDefaults.sharedInstance().domain {
            
            domain = d
        }
        
        if let d = self.domain {
            
            domain = d
        }
        
        return domain
    }
    
    private func mutableUrl(id: Int) -> String? {
        
        if encryptComponents {
            
            //var secretComponent = Encryptor.encrypt("api", key: kKey)
            var eRestKey = Encryptor.encrypt(restKey!, key: kKey)
            var eID = Encryptor.encrypt("\(id)", key: kKey)
            
            return validRestUrlSet() ? "\(getDomain())/apih/\(eRestKey)/\(eID)" : nil
        }
        
        return validRestUrlSet() ? "\(getDomain())/api/\(restKey!)/\(id)" : nil
    }
    
    private func staticUrl() -> String? {
        
        if encryptComponents {
            
            //var secretComponent = Encryptor.encrypt("api", key: kKey)
            var eRestKey = Encryptor.encrypt(restKey!, key: kKey)
            
            return validRestUrlSet() ? "\(getDomain())/apih/\(eRestKey)" : nil
        }
        
        return validRestUrlSet() ? "\(getDomain())/api/\(restKey!)" : nil
    }
    
    public func updateUrl(id: Int?) -> String? {
        
        if let id = id {
            
            return mutableUrl(id)
        }
        
        return nil
    }
    
    public func insertUrl() -> String? {
        
        return staticUrl()
    }
    
    public func getUrl(id: Int) -> String? {
        
        return mutableUrl(id)
    }
    
    public func getMultipleUrl() -> String? {
        
        return staticUrl()
    }
    
    public func deleteUrl(id: Int?) -> String? {
        
        if let id = id {
            
            return mutableUrl(id)
        }
        
        return nil
    }
    
    public func validRestUrlSet() -> Bool {
     
        return restKey != nil
    }
}
