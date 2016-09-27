//
//  ViewController.swift
//  codequiz
//
//  Created by Marcos Polanco on 9/24/16.
//  Copyright © 2016 Visor Labs. All rights reserved.
//

import UIKit
import SwiftyMarkdown

class ViewController: UIViewController {
    @IBOutlet weak var input: UITextView!
    
    var challenge: Challenge?
    var responseTable: ResponseTableController?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let challenge = self.challenge else {return}
        
        self.input.text = challenge.question
    }
    
    override func addChildViewController(childController: UIViewController) {
        super.addChildViewController(childController)
        if let responseTable = childController as? ResponseTableController {
            self.responseTable = responseTable
            responseTable.controller = self
            responseTable.responses = self.challenge?.responses ?? [Response]()
        }
    }

//    @IBAction func process(sender: AnyObject) {
//        output.attributedText = SwiftyMarkdown(string: input.text).attributedString()
//        
//        var m = Markdown()
//        webView.loadHTMLString(m.transform(input.text), baseURL: nil)
//    }
}


class ResponseTableController: UITableViewController {
    var responses = [Response]()
    var controller: ViewController?
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.responses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResponseCell")!
        cell.textLabel?.text = responses[indexPath.row].response
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let response = self.responses[indexPath.row]
        self.controller?.challenge?.answer = response
        self.controller?.view.backgroundColor = response.correct ? .greenColor() : .redColor()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}

