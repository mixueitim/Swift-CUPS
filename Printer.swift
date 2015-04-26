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
    init(printer_name : String)
    {
        self.name = printer_name;
    }
    
    internal var description: String {
        return "[Printer \(name)]"
    }
}