//
//  ChatManager.swift
//  iPrototype
//
//  Created by Jack on 1/28/18.
//  Copyright © 2018 Jack. All rights reserved.
//

import Foundation

class ChatManager {
    
    static let sharedInstance = ChatManager()
    
    var messages = [Dictionary<String, Any>]()
    
    func getMessages(pageNumber: Int, completion: @escaping (_ success: Bool, _ result: Any?, _ message: String?) -> () ) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            var resultArray = ArraySlice<Dictionary<String, Any>>()
            if let url = Bundle.main.url(forResource: "ChatHistory", withExtension: "plist") {
                if let array = NSArray.init(contentsOf: url) as? [Dictionary<String, Any>] {
                    let sortedArray = array.sorted(by: {Double((($0["date_created"] as! Date).timeIntervalSince1970))  > Double((($1["date_created"] as! Date).timeIntervalSince1970))})

                    let startIndex = (pageNumber - 1) * 20
                    var endIndex = 19 + (pageNumber - 1) * 20
                    if endIndex > sortedArray.count {
                        endIndex = array.count - 1
                    }
                    if endIndex < sortedArray.count {
                        resultArray = sortedArray[startIndex...endIndex]
                        self.messages += resultArray
                        self.messages = self.messages.sorted(by: {Double((($0["date_created"] as! Date).timeIntervalSince1970)) < Double((($1["date_created"] as! Date).timeIntervalSince1970))})
                    }
                    completion(true, resultArray, nil)
                }
            }
        })
    }
    
    func getMessageAtIndex(_ index: Int) -> Dictionary<String, Any>? {
        if index > self.messages.count {
            return nil
        }
        return self.messages[index]
    }
}
