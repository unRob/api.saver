//
//  MainViewController.swift
//  APIScreenSaver
//
//  Created by Roberto Hidalgo on 3/28/16.
//  Copyright © 2016 Roberto Hidalgo. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var location: NSTextField!
    @IBOutlet weak var year: NSTextField!
    @IBOutlet weak var time: NSTextField!
    
    var timer: NSTimer! = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true;
//        self.view.layer?.backgroundColor = NSColor.grayColor().CGColor
        
        imageView.frame = self.view.bounds
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.imageScaling = NSImageScaling.ScaleProportionallyUpOrDown
        imageView.wantsLayer = true
        
        location.hidden = true
        year.hidden = true
        
        tick()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.tick), userInfo: nil, repeats: true)
    }
    
    func setImage (media: SSMedia) {
        imageView.image = media.image
        if (media.sublocation != nil && media.location != nil) {
            location.hidden = false
            location.stringValue = " \(media.sublocation!), \(media.location!) "
            location.sizeToFit()
        } else {
            location.hidden = true
        }
        
        if media.year != nil {
            year.hidden = false
            year.stringValue = " \(media.year!) "
            year.sizeToFit()
        } else {
            year.hidden = true
        }
    }
    
    internal func tick() {
        let currTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        time.stringValue = " \(currTime) "
        time.sizeToFit()
    }
    
}
