//
//  Models.swift
//  codequiz
//
//  Created by Marcos Polanco on 9/26/16.
//  Copyright © 2016 Visor Labs. All rights reserved.
//

import Foundation

struct Database: JSONABLE {
    static var sharedInstance = Database()
    
    private init(){}

    let user = User(username: "", password: "")
    var challenges = [Challenge]()
    
    mutating func data() {
        challenges.append(Challenge(question: "What is the difference between let and var", responses: [
            Response(response: "let variables are limited to the local scope", explanation: "", correct: false),
            Response(response: "let varibables are constants.", explanation: "", correct: true)
            ]))
        challenges.append(Challenge(question: "What is the difference between class and struct?", responses: [
            Response(response: "structs cannot conform to protocols", explanation: "", correct: false),
            Response(response: "structs are passed by value", explanation: "", correct: true)
            ]))
    }
    
    func json() -> [String:Any] {
        return ["challenges":self.challenges.map{$0.json()}]
    }
}

extension String {
    func log(message:String = "") {
        print("\(message):\(self)")
    }
}

protocol JSONABLE {
    func json() -> [String:Any]
    func jstr() -> String
}

extension Array: JSONABLE {
    
    private func render(object:Any, last:Any?) -> String {
        let result =  (object as? JSONABLE)?.jstr() ?? ""
        return "\(result),"//if let last = last where object === last {return "\(result),"} else {return result}
    }
    
    func json() -> [String:Any] {fatalError()}
    func jstr() -> String {return "[\(self.map{element in render(element, last:self.last)}.reduce("",combine:+))]"}
}

extension JSONABLE {
    func jstr() -> String {
        let _json = json()
        return "{\(_json.keys.map{key in "\(key):\((_json[key] as? JSONABLE)?.jstr() ?? "")"})}"
    }
}

//extension Array<String>: JSONABLE {
//    func json() -> [String: Any] {
//        return map{$0.json()}.reduce([String:Any](), combine:{})
//    }
//}

struct User {
    let username: String
    let password: String
}

extension User: JSONABLE {
    func json() -> [String:Any] {
        return ["username":username, "password":password]
    }

}

struct Challenge : JSONABLE {
    let question: String
    let responses: [Response]
    
    func json() -> [String:Any] {
        return ["question":question, "responses":self.responses.map{$0.json()}]
    }
}

struct Response: JSONABLE {
    let response: String
    let explanation: String
    let correct: Bool
    
    func json() -> [String:Any] {
        return ["response":response, "explanation":explanation, "correct":correct]
    }
}