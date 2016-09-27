//
//  TestTableController.swift
//  codequiz
//
//  Created by Marcos Polanco on 9/26/16.
//  Copyright © 2016 Visor Labs. All rights reserved.
//

import Foundation
import UIKit


class TestTableController: UITableViewController {
    
    var challenges = [Challenge]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.reload()
    }
    
    func reload() {
        self.challenges = Database.sharedInstance.challenges.filter{$0.answer == nil}
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TestViewCell")!
        cell.textLabel?.text = challenges[indexPath.row].question
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        challenge = challenges[indexPath.row]
        self.performSegueWithIdentifier("showChallenge", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? ViewController {
            destination.challenge = self.challenge
        }
    }
    
    //struct 
    var challenge: Challenge?
}
