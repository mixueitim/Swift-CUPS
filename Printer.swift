//
//  Printer.swift
//  UPrint DST
//
//  Created by Pat Sabpisal on 4/25/15.
//  Copyright (c) 2015 Pat Sabpisal. All rights reserved.
//

import Foundation

class Printer : Printable{
    var name : String = "";
    var url : NSURL;
    init(printer_name : String, printer_url: NSURL)
    {
        self.name = printer_name;
        self.url = printer_url;
    }
    
    internal var description: String {
        return "[Printer \(name) \(url)]"
    }
}