//
//  CUPS.swift
//  UPrint DST (Distributed)
//
//  Created by Pat Sabpisal on 4/20/15.
//  Copyright (c) 2015 Pat Sabpisal. All rights reserved.
//

import Foundation

class CUPS {
    
    var charset : String = "utf-8";
    var language : String = "en-us";
    var requestId : Int32 = 0;
    
    var username : String = "";
    var password : String = "";
    
    
    init(url: NSURL){
        if(url.scheme == "ipp"){
            //set it to http
        }
        NSLog("Will connect %@", url);
    }
    
    func getNextRequestId() -> Int32{
        self.requestId += 1 ;
        return self.requestId;
    }
}