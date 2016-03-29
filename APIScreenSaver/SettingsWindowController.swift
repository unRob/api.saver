//
//  SettingsWindowController.swift
//  APIScreenSaver
//
//  Created by Roberto Hidalgo on 3/7/16.
//  Copyright © 2016 Roberto Hidalgo. All rights reserved.
//

import AppKit

class SettingsWindowController: NSWindowController {


    @IBOutlet weak var duration: NSSlider!
    @IBOutlet weak var durationText: NSTextField!
    @IBOutlet weak var doneButton: NSButton!
    
    var mainW: NSWindow = NSWindow()
    
    override var windowNibName: String! {
        return "Preferences"
    }
    
    
    @IBAction func doneClicked (sender: AnyObject?) {
        endSheet()
    }
    
    func endSheet() {
        self.window!.endSheet(self.window!)
    }
    
    @IBAction func slider(sender: NSSlider) {
        durationText.stringValue = sender.stringValue
    }
}