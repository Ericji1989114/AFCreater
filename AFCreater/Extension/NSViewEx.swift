//
//  NSViewEx.swift
//  AFCreater
//
//  Created by Ki, Un | Eric | PAYSD on 2019/03/13.
//  Copyright © 2019 Ericji. All rights reserved.
//

import Cocoa

extension NSView {
    
    var backgroundColor: NSColor? {
        
        get {
            guard let _ = self.layer, let color = self.layer?.backgroundColor else {
                return nil
            }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
        
    }
    
    var coreradius: CGFloat? {
        
        get {
            guard let _ = self.layer else {
                return nil
            }
            return self.layer?.cornerRadius
        }
        set {
            self.layer?.cornerRadius = newValue ?? 0
        }
        
    }
    
}
