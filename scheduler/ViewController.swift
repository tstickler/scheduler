//
//  ViewController.swift
//  scheduler
//
//  Created by Tyler Stickler on 2/27/20.
//  Copyright © 2020 Tyler Stickler. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let networker = Networking()
        networker.getData(fromPath: "users") {
            data, err in
            
            if let error = err {
                print("Error occurred fetching at path users err: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            print(data)
        }
    }


}


