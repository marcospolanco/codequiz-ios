//
//  LoginController.swift
//  codequiz
//
//  Created by Marcos Polanco on 9/28/16.
//  Copyright © 2016 Visor Labs. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class LoginController: UIViewController {
    @IBOutlet weak var username: RoundedTextField!
    @IBOutlet weak var password: RoundedTextField!
    @IBOutlet weak var loginBut: RoundedButton!
    @IBOutlet weak var fbLogin: FBSDKLoginButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.fbLogin.readPermissions = ["email","public_profile"]
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            
            //get the credential.
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            FIRAuth.auth()?.signInWithCredential(credential, completion: {user, error in
                guard let user = user where error == nil else {
                    return print("signInWithCredential: \(error)")
                }
                
                //set the current user
                Database.sharedInstance.user = user
                
                Threads.onMain{
                    //self.performSegueWithIdentifier(UI.Segue.login.rawValue, sender: self)
                }
                
            })
            
        }
        
        //if the user is coming back from facebook login, get out of here
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func login(sender: AnyObject) {
        guard let codename = username.text, password = password.text, auth = FIRAuth.auth() else {return print("cannot login")}
        
        auth.signInWithEmail(codename, password: password) { (user, error) in
            guard let user = user else {return print("error: \(error)")}
            
            //updateh the authenticated user
            AppFlow.appFlow.user = user
            
            //go to main. This should really be done by AppFlow
            self.performSegueWithIdentifier(Segues.toMain.rawValue, sender: self)
        }
    }
}


class RoundedButton: UIButton {
    override func awakeFromNib() {
        
        //rounded corners
        self.layer.cornerRadius = self.frame.height / 2
    }
}

class RoundedTextField: UITextField {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.whiteColor().CGColor
    }
}
