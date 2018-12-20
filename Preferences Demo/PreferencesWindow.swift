//
//  PreferencesWindow.swift
//  Preferences Demo
//
//  Created by 1024jp on 2018-12-20.
//  © 2018 1024jp
//

import Cocoa

final class PreferencesWindow: NSPanel {
    
    // MARK: Panel Methods
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        
        switch menuItem.action {
        case #selector(toggleToolbarShown)?:
            return false
            
        default:
            return super.validateMenuItem(menuItem)
        }
    }
    
}
