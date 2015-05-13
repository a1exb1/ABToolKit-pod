//
//  JavaScriptAnalyzer.swift
//  CompresJSON
//
//  Created by Alex Bechmann on 12/05/2015.
//  Copyright (c) 2015 Alex Bechmann. All rights reserved.
//

import UIKit
import JavaScriptCore

let kJavascriptAnalyzerSharedInstance = JavaScriptAnalyzer()

class JavaScriptAnalyzer: NSObject {
   
    var context: JSContext?
    
    class func sharedInstance() -> JavaScriptAnalyzer {
        
        return kJavascriptAnalyzerSharedInstance
    }
    
    func loadScript(path: String) {
        
        let resource = NSBundle.mainBundle().pathForResource(path, ofType: "txt")!
        
        var error: NSError?
        let script = String(contentsOfFile: resource, encoding: NSUTF8StringEncoding, error: &error)
        
        context = JSContext()
        context?.evaluateScript(script)
    }
    
    func executeJavaScriptFunction(functionName: String, args:Array<AnyObject>) -> JSValue {
        
        let function = context!.objectForKeyedSubscript(functionName)
        return function.callWithArguments(args)
        
    }
    
}
