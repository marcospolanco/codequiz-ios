//
//  System.swift
//  codequiz
//
//  Created by Marcos Polanco on 9/26/16.
//  Copyright © 2016 Visor Labs. All rights reserved.
//

import Foundation

//simple method to execute a block on the main thread
extension NSOperationQueue {
    static func onMain(block: () -> Void) {
        NSOperationQueue.mainQueue().addOperation(NSBlockOperation(block: block))
    }
    
    static func onBack(block: () -> Void) {
        let queue = NSOperationQueue()
        queue.addOperationWithBlock(block)
    }
    
    static func asyncSleep(interval: NSTimeInterval, block: () -> Void) {
        self.onBack() {
            NSThread.sleepForTimeInterval(interval)
            self.onMain(block)
        }
    }
}

//alias to make code more readable
typealias Threads = NSOperationQueue