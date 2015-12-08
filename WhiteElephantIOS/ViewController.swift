//
//  ViewController.swift
//  WhiteElephantIOS
//
//  Created by Skyler Parr on 12/3/15.
//  Copyright © 2015 Skyler Parr. All rights reserved.
//

import UIKit
import SwiftPhoenixClient
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var roomIdTextField: UITextField!
    @IBOutlet weak var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connectTapped(sender: AnyObject) {
        let socket = Phoenix.Socket(domainAndPort: "localhost:4000", path: "socket", transport: "websocket")
        
        let topic: String = "games:\(roomIdTextField.text!)"
        
        NSLog(topic)
        
        socket.join(topic: topic, message: Phoenix.Message(subject: "status", body: "joining"), callback: { channel in
            let chan = channel as! Phoenix.Channel
            chan.on("phx_reply") { message in
                NSLog("joined")
            }
            chan.on("item_updated") { message in
                let msg = message as! Phoenix.Message
                self.itemUpdated(msg.message!)
            }
        })
    }
    
    func itemUpdated(message: AnyObject) {
//        let json = SwiftyJSON.JSON.parse(message)
//        NSLog(json["event"].string!);
    }

}

