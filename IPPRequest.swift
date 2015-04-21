//
//  IPPRequest.swift
//  UPrint DST
//
//  Created by Pat Sabpisal on 4/21/15.
//  Copyright (c) 2015 Pat Sabpisal. All rights reserved.
//

import Foundation

class IPPRequest{
    var operationId : Int16 = 0x0000;
    var requestId : Int16 = 0x0000;
    var data : [Int8] = [0x00];
    
    init(){
        
    }
}