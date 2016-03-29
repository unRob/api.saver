//
//  ImageStreamView.swift
//  APIScreenSaver
//
//  Created by Roberto Hidalgo on 3/4/16.
//  Copyright © 2016 Roberto Hidalgo. All rights reserved.
//

import AppKit
import GameKit
import ScreenSaver

class ImageStreamView: ScreenSaverView {
    
    var media: MediaBucket!
    
    var index = 0
    var images: [NSImage] = []
    var currentImage: NSImage?
    var mainView: MainViewController!
    let prefs = NSUserDefaults.standardUserDefaults()
    
    let animationDuration: NSTimeInterval = 1
    
    
    #if PREFERENCES
    let PREFERENCES_ENABLED = true
    private let prefsWindow: SettingsWindowController = {
        let controller = SettingsWindowController()
        return controller
    }()
    #else
    let PREFERENCES_ENABLED = false
    #endif
    
    override init?(frame: NSRect, isPreview: Bool) {
        
        super.init(frame: frame, isPreview: isPreview)
        
        self.mainView = MainViewController(nibName: "MainViewController", bundle: NSBundle(forClass: self.classForCoder))!
        super.wantsLayer = true;
        super.layer?.backgroundColor = NSColor.blackColor().CGColor
        readPreferences()
    }
    
    private func readPreferences() {
        
        let fileManager = NSFileManager.defaultManager()
        let picturesURL = fileManager.URLsForDirectory(.PicturesDirectory, inDomains: .UserDomainMask)[0] as NSURL
        let base: NSURL! = picturesURL.URLByAppendingPathComponent("best of")
        
        prefs.registerDefaults([
            "duration": 10,
        ])
        prefs.setURL(base, forKey: "path")
    }
    
    private func imagesAtPath() -> Array<SSMedia> {
        let fileManager = NSFileManager.defaultManager()
        
        let enopts = NSDirectoryEnumerationOptions.SkipsHiddenFiles
        let enumerator: NSDirectoryEnumerator! = fileManager.enumeratorAtURL(prefs.URLForKey("path")!, includingPropertiesForKeys: nil, options: enopts) { (url, err) -> Bool in
            Swift.print(url)
            Swift.print(err)
            return false
        }
        
        return enumerator.map {item in SSMedia(at_path: NSURL(string: "file://\(item)")!) }
    }
    
    func loadImages () {
        media = MediaBucket(items: imagesAtPath())
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func startAnimation() {
        super.startAnimation()
        addSubview(mainView.view)
        loadImages()
        nextImage()
        self.needsDisplay = true
    }
    
    override func stopAnimation() {
        super.stopAnimation()
        mainView.view.removeFromSuperview()
    }
    
    
    func nextImage () {
        CATransaction.begin()
        let nextMedia: SSMedia! = media!.next()
        let switchingInterval: NSTimeInterval = NSTimeInterval(self.prefs.integerForKey("duration"))
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(switchingInterval * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                if self.animating {
                    self.nextImage()
                }
            }
        }
        
        let transition: CATransition! = CATransition()
        transition.type = kCATransitionFade
        mainView.imageView.layer!.addAnimation(transition, forKey: kCATransition)
        mainView.setImage(nextMedia)
        self.needsDisplay = true
        
        CATransaction.commit()
    }
    
    override func drawRect(rect: NSRect) {
        mainView.view.frame = super.bounds
    }
    
    
    override func animateOneFrame() {
        
    }
    
    override func hasConfigureSheet() -> Bool {
        return PREFERENCES_ENABLED
    }
    
    override func configureSheet() -> NSWindow? {
        #if PREFERENCES
            prefsWindow.showWindow(nil)
            prefsWindow.loadWindow()
            debugPrint(prefsWindow.window == nil)
            return prefsWindow.window
        #endif
        return nil
    }
    
}