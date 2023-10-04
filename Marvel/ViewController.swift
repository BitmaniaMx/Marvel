//
//  ViewController.swift
//  Marvel
//
//  Created by Rafael González on 30/09/23.
//

import UIKit

class ViewController: UIViewController {

    var myKeys : KeyLoader?
    var myTS = 0.0
    var myHash = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myKeys = KeyLoader.shared
        myTS = Date().timeIntervalSince1970
        print("private key: ", myKeys!.privateKey)
        print("public key: ", myKeys!.publicKey)
        print("ts: ", myTS)
        
        print("qs:", myKeys!.getQueryString())
        
    }
}

