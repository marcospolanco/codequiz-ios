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
    @IBOutlet weak var output: UITextView!
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func process(sender: AnyObject) {
        output.attributedText = SwiftyMarkdown(string: input.text).attributedString()
        
        var m = Markdown()
        webView.loadHTMLString(m.transform(input.text), baseURL: nil)
    }
}
