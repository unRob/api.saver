//
//  AppDelegate.swift
//  APISS-dev
//
//  Created by Roberto Hidalgo on 3/4/16.
//  Copyright © 2016 Roberto Hidalgo. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    @IBOutlet weak var window: NSWindow!

    lazy var screenSaverView = ImageStreamView(frame: NSZeroRect, isPreview: false)

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let screenSaverView = screenSaverView {
            screenSaverView.frame = window.contentView!.bounds;
            window.contentView!.addSubview(screenSaverView);
            window.delegate = self;
            screenSaverView.startAnimation()
        }
    }
    
    func windowDidResize(notification: NSNotification) {
        screenSaverView!.frame = window.contentView!.bounds;
    }
    

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @objc private func endSheet(sheet: NSWindow) {
        sheet.close()
    }
    
    @IBAction func showPreferences(sender: NSObject!) {
        guard let sheet = screenSaverView!.configureSheet() else { return }
        
//        window.beginSheet(sheet, completionHandler: { responseCode in
//            debugPrint("close")
//            self.window.endSheet(sheet)
////            sheet.close()
//        })
        NSApp.beginSheet(sheet, modalForWindow: window, modalDelegate: self, didEndSelector: #selector(AppDelegate.endSheet(_:)), contextInfo: nil)
    }

}

