//
//  NSObject+Extensions.swift
//  iPrototype
//
//  Created by Jack on 1/26/18.
//  Copyright © 2018 Jack. All rights reserved.
//

import Foundation

import Foundation

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
