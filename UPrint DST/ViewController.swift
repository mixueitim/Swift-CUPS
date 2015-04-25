//
//  ViewController.swift
//  UPrint DST
//
//  Created by Pat Sabpisal on 4/20/15.
//  Copyright (c) 2015 Pat Sabpisal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var server = NSURL(string: "http://picket.ics.purdue.edu:631/version=1.1");
        var c = CUPS(url: server!);
        c.getPrinters();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

