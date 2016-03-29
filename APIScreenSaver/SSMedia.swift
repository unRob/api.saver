//
//  SSMedia.swift
//  APIScreenSaver
//
//  Created by Roberto Hidalgo on 3/8/16.
//  Copyright © 2016 Roberto Hidalgo. All rights reserved.
//

import Cocoa
import ImageIO

public class SSMedia {

    private var path: NSURL!
    var image: NSImage!
    var sublocation: String?
    var location: String?
    var year: String?
       
    init(at_path: NSURL) {
        self.path = at_path
        
        let cgDataRef = CGImageSourceCreateWithURL(path, nil)
        let metadata:NSDictionary = CGImageSourceCopyPropertiesAtIndex(cgDataRef!, 0, nil)! as NSDictionary
        let iptc: Dictionary? = metadata[kCGImagePropertyIPTCDictionary as String] as? Dictionary<String, AnyObject>
        
        if (iptc != nil) {
            let created: String! = iptc![kCGImagePropertyIPTCDateCreated as String] as! String
            self.year = created.substringToIndex(created.startIndex.advancedBy(4))
            self.location = iptc![kCGImagePropertyIPTCProvinceState as String] as? String
            self.sublocation = iptc![kCGImagePropertyIPTCSubLocation as String] as? String
//            debugPrint("\(sublocation), \(location) -> (\(year))")
        } else {
//            debugPrint("sin iptc \(path)")
        }
        self.image = NSImage(contentsOfURL: at_path)
    }
    
    
}
