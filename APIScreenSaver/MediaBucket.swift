//
//  MediaBucket.swift
//  APIScreenSaver
//
//  Created by Roberto Hidalgo on 3/8/16.
//  Copyright © 2016 Roberto Hidalgo. All rights reserved.
//

import GameKit

public struct MediaBucket {
    private var items: [SSMedia];
    private var index: Int = 0;


    init(items: [SSMedia]) {
        self.items = items
        shuffle()
    }
    
    private mutating func shuffle() {
        var candidates = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(items) as! [SSMedia]
        while candidates.first === items.last {
            candidates = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(items) as! [SSMedia]
        }
        
        items = candidates
    }

    public mutating func next() -> SSMedia? {
        let total = items.count
        if (total == 0) {
            return nil
        }
        
        if (total == index-1) {
            shuffle()
            index = 0
        }
        
        let current = items[index]
        index += 1
        return current
    }
}