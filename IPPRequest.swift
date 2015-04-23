//
//  IPPRequest.swift
//  UPrint DST
//
//  Created by Pat Sabpisal on 4/21/15.
//  Copyright (c) 2015 Pat Sabpisal. All rights reserved.
//

import Foundation

public class Property{
    
    public static var ENUM = "enum";
    public static var BOOLEAN = "boolean";
    public static var INTEGER = "integer";
    public static var GENERIC_INTEGER = "generic-integer";
    
    var stringValue: String = "";
    var int32Value : UInt32 = 0;
    public var propertyType: String;
    
    init(prop: String, value: UInt32){
        propertyType = prop;
        int32Value = value;
    }
    
    init(prop: String, value : String){
        propertyType = prop;
        stringValue = value;
    }

    func getString() -> String{
        return stringValue;
    }
    
    func getInt32() -> UInt32{
        return int32Value;
    }
}

public class IPPRequest{
    var operationId : UInt16 = 0x0000;
    var requestId : UInt32 = 0;
    var data : NSData;
    
    var version : UInt8;
    var subVersion : UInt8;
    
    var tags : Dictionary<String, UInt8>;
    var operation_attr : Dictionary<String, Property>;
    var job_attr : Dictionary<String, Property>;
    var printer_attr : Dictionary<String, Property>;
    var unsupported_attr : Dictionary<String, Property>;
    var subscription_attr : Dictionary<String, Property>;
    var event_notification_attr : Dictionary<String, Property>;

    
    init(OpID: UInt16, requestID: UInt32, data: NSData){
        // Initializes message

        
        self.operationId = OpID;
        self.requestId = requestID;
        self.data = data;
        self.version = 0x01;
        self.subVersion = 0x01;
        
        operation_attr = Dictionary<String, Property>();
        job_attr = Dictionary<String, Property>();
        printer_attr = Dictionary<String, Property>();
        unsupported_attr = Dictionary<String, Property>();
        subscription_attr = Dictionary<String, Property>();
        event_notification_attr = Dictionary<String, Property>();

        tags = ["operation-attributes-tag": 0x01,
            "job-attributes-tag": 0x02,
            "end-of-attributes-tag": 0x03,
            "printer-attributes-tag": 0x04,
            "unsupported-attributes-tag" :0x05,
            "subscription-attributes-tag" : 0x06,
            "event_notification-attributes-tag" : 0x07,
            "unsupported" : 0x10,
            "reserved-for-future-default" : 0x11,
            "unknown" : 0x12,
            "no-value" : 0x13,
            "not-settable" : 0x15,
            "delete-attribute" : 0x16,
            "admin-define" : 0x17,
            "generic-integer" : 0x20,
            "integer" : 0x21,
            "boolean" : 0x22,
            "enum" : 0x23,
            "octetString-with-an-unspecified-format" : 0x30,
            "dateTime" : 0x31,
            "resolution" : 0x32,
            "rangeOfInteger" : 0x33,
            "begCollection" : 0x34,
            "textWithLanguage" : 0x35,
            "nameWithLanguage" : 0x36,
            "endCollection" : 0x37,
            "generic-character-string" : 0x40,
            "textWithoutLanguage" : 0x41,
            "nameWithoutLanguage" : 0x42,
            "keyword" : 0x44,
            "uri" : 0x45,
            "uriScheme" : 0x46,
            "charset" : 0x47,
            "naturalLanguage" : 0x48,
            "mimeMediaType" : 0x49,
            "memberAttrName" : 0x4];
    }
    
    func setOperationAttribute(attrname: String, prop: Property){
        self.operation_attr[attrname] = prop;
    }
    
    func setRequestId(rqid: UInt32){
        self.requestId = rqid;
    }
    
    
    func dump() -> NSData {
        var xbuffer = [UInt8](count:2048, repeatedValue:0)
        var stream : NSOutputStream = NSOutputStream(toBuffer: &xbuffer, capacity: 2048);
        stream.open();
        
        //Version number (2 bytes)
        stream.write(UnsafePointer(NSData(bytes: &(self.version), length: 1).bytes),
            maxLength: 1);
        stream.write(UnsafePointer(NSData(bytes: &(self.subVersion), length: 1).bytes),
            maxLength: 1);
        //Operation ID status code (2 bytes)
        var opId_big = CFSwapInt16HostToBig(self.operationId);
        stream.write(UnsafePointer(NSData(bytes: &(opId_big), length: 2).bytes),
            maxLength: 2);
        //Request ID (4 bytes)
        requestId = requestId | 0x01;
        var rqid_big = CFSwapInt32HostToBig(requestId);
        stream.write(UnsafePointer(NSData(bytes: &(rqid_big), length: 4).bytes),
            maxLength: 4);
        
        /* Attributes (N bytes)
         * Iterate through all 6 attribute lists
         * and build buffer
        */
        
        //---- Operation Attribute
        stream.write(UnsafePointer(NSData(bytes: &tags["operation-attributes-tag"]!, length: 1).bytes),
            maxLength: 1);
        for (attrname, prop) in operation_attr{
            NSLog("%@ = %@",attrname, prop.propertyType);
            //start byte depending on what type data is
            stream.write(UnsafePointer(NSData(bytes: &tags[prop.propertyType]!, length: 1).bytes),
                maxLength: 1);
            
            //TODO: python reference impl contains additional (nameprinted)
            // check, but i think its redundant
            
            //length of attribute name (2 bytes)
            var attrname_len : UInt16 = CFSwapInt16HostToBig((UInt16)(count(attrname)));
            stream.write(UnsafePointer(NSData(bytes: &attrname_len, length: 2).bytes),
                maxLength: 2);
            //value of attribute name
            stream.write(attrname,
                maxLength: count(attrname));
            
            
            if ( prop.propertyType == Property.INTEGER || prop.propertyType == Property.ENUM ){
                //2 bytes of int value 4
                var operandIntEnum = CFSwapInt16HostToBig(0x0004);
                stream.write(UnsafePointer(NSData(bytes: &operandIntEnum, length: 2).bytes),
                    maxLength: 2);
                //4 more bytes of actual data
                var data_big = CFSwapInt32HostToBig(prop.getInt32());
                stream.write(UnsafePointer(NSData(bytes: &data_big, length: 2).bytes),
                    maxLength: 2);

            }
        }
        
        
        
        stream.close();
        //end of attrs
        xbuffer.append(tags["end-of-attributes-tag"]!);
        
        /*if(self.data.length == 0){
            buffer.append(self.data.bytes);
        }*/
        return NSData(bytes: xbuffer, length: xbuffer.count);
    }
}