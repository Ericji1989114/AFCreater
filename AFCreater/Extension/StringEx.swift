//
//  StringEx.swift
//  AFCreater
//
//  Created by Ki, Un | Eric | PAYSD on 2019/03/14.
//  Copyright © 2019 Ericji. All rights reserved.
//

import Cocoa

extension String {
    
    // string should be a normal path
    var fileName: String {
        return (self as NSString).lastPathComponent
    }
    
    // string should be a normal path
    var fileNameWithExt: String {
        return (self.fileName as NSString).deletingPathExtension
    }
    
}
