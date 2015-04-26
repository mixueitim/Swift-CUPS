//
//  IPPRequest.swift
//  UPrint DST
//
//  Created by Pat Sabpisal on 4/21/15.
//  Copyright (c) 2015 Pat Sabpisal. All rights reserved.
//

import Foundation

public class Property : Printable{
    
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
    
    public var description: String {
        return "(\(propertyType), \(stringValue))"
    }
}

public class IPPMessage{
    var operationId : UInt16 = 0x0000;
    var requestId : UInt32 = 0;
    var data : NSData? = nil;
    
    var version : UInt8 = 0x01;
    var subVersion : UInt8 = 0x01;
    
    var tags : Dictionary<String, UInt8> =    ["operation-attributes-tag": 0x01,
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
    
    var tags_reverse = Dictionary<UInt8, String>();
    
    public static let OPERATION_ATTRIBUTES : String = "operation-attributes-tag";
    public static let JOB_ATTRIBUTES: String = "job-attributes-tag";
    public static let END_OF_ATTRIBUTES : String = "end-of-attributes-tag";
    public static let PRINTER_ATTRIBUTES : String = "printer-attributes-tag";
    public static let UNSUPPORTED_ATTRIBUTES : String = "unsupported-attributes-tag";
    public static let SUBSCRIPTION_ATTRIBUTES : String = "subscription-attributes-tag";
    public static let EVENT_NOTIFICATION_ATTRIBUTES : String = "event_notification-attributes-tag";
    
    
    var attributes : Dictionary<String, [(String, Property)]> = [
        OPERATION_ATTRIBUTES: [(String, Property)](),
        JOB_ATTRIBUTES: [(String, Property)](),
        END_OF_ATTRIBUTES: [(String, Property)](),
        PRINTER_ATTRIBUTES: [(String, Property)](),
        UNSUPPORTED_ATTRIBUTES :[(String, Property)](),
        SUBSCRIPTION_ATTRIBUTES : [(String, Property)](),
        EVENT_NOTIFICATION_ATTRIBUTES: [(String, Property)]()
    ];
    
    init(serializeddata: NSData){
        self.operationId = 0;
        self.requestId = 0;
        
        for (key, value) in tags
        {
            tags_reverse[value] = key;
        }


        
        self.parse(serializeddata);
        
    }
    
    init(OpID: UInt16 = 0, requestID: UInt32 = 0){
        // Initializes message

        self.operationId = OpID;
        self.requestId = requestID;

    }
    
    //init(OpID, requestID, fileData)
    
    func setOperationAttribute(attrname: String, prop: Property){
        (self.attributes["operation-attributes-tag"]!).append( (attrname, prop) );
    }
    
    func setRequestId(rqid: UInt32){
        self.requestId = rqid;
    }
    
    func parse(data : NSData){
        // RFC2910
        var tbuff = [UInt8](count: data.length, repeatedValue:0);
        data.getBytes(&tbuff, length: data.length);
        
        // Set version
        self.version = tbuff[0];
        // Set subversion
        self.subVersion = tbuff[1];
        // Set Operation Id
        let bytes:[UInt8] = [tbuff[2], tbuff[3]];
        self.operationId = UnsafePointer<UInt16>(bytes).memory;
        //TODO: Could there be Byte order problem?
        // set Request Id
        
        
        var curbyte = 8;
        var r = tbuff[curbyte];
        var currentTagValue : String = "";
        do {
            if( curbyte >= tbuff.count ){
                if(Configs.DEBUG_NETWORK){
                    println("Unexpected end of message");
                }
                return;
            }
            
            r = tbuff[curbyte++];
            let dtagname = self.tags_reverse[r];
            if(dtagname != nil){
                
                if(r > 0x07){
                    //exceed maximum delimiter can be
                    //so its not a delimiter
                    curbyte--; //revert back to previous byte
                    //re interpret the byte as a strtag
                }else{
                    if(Configs.DEBUG_NETWORK){
                        print("DTAG: " + dtagname! + " value: ");
                        println(r);
                    }
                    currentTagValue = dtagname!;
                }
                
                
        
                let stt = tbuff[curbyte++];
                var str_tag_type = self.tags_reverse[stt];
                
                if(Configs.DEBUG_NETWORK){
                    print(str_tag_type! + ": ");
                }
                
                
                //Find Length of (key) value Tag (2 bytes)
                let bup : UInt16 = (UInt16)(tbuff[curbyte++]);
                let blo : UInt16 = (UInt16)(tbuff[curbyte++]);
                let blen : UInt16 = ( (bup << 8) | blo);
                
                var tmpr_reconstruct : String = "";
                
                //read blen more bytes
                for var off : UInt16 = 0; off < blen; ++off{
                    let tmpr = tbuff[curbyte++];
                    if(Configs.DEBUG_NETWORK){
                        print(UnicodeScalar(tmpr));
                    }
                    tmpr_reconstruct = tmpr_reconstruct + String(UnicodeScalar(tmpr));
                }
                
                var value_reconstruct : String = "";

                if(Configs.DEBUG_NETWORK){
                    println("");
                    print("Value: ");
                }
                
                //Find length of data corresponding to value tag (probably 1 byte)
                let bup2 : UInt16 = (UInt16)(tbuff[curbyte++]);
                let blo2 : UInt16 = (UInt16)(tbuff[curbyte++]);
                let blen2 : UInt16 = ( (bup2 << 8) | blo2);
                
                //read blen more bytes
                for var off : UInt16 = 0; off < blen2; ++off{
                    let tmpr = tbuff[curbyte++];
                    if(Configs.DEBUG_NETWORK){
                        print(UnicodeScalar(tmpr));
                    }
                    value_reconstruct = value_reconstruct + String(UnicodeScalar(tmpr));
                }
                if(Configs.DEBUG_NETWORK){
                    println(" *");
                }
                
                //TODO: How do we handle Int32 type `value_reconstruct`
                (self.attributes[currentTagValue]!).append( tmpr_reconstruct as String, Property(prop: str_tag_type!, value: value_reconstruct)   );

            }
        }while(tbuff[curbyte] != self.tags["end-of-attributes-tag"]);
        
    }
    
    func dump() -> NSData {
        var xbuffer = [UInt8](count:2048,
            repeatedValue:0)
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
        requestId = requestId | 0x0001;
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
        for (attrname, prop) in (self.attributes["operation-attributes-tag"]!){
            //start byte depending on what type data is
            stream.write(UnsafePointer(NSData(bytes: &tags[prop.propertyType]!, length: 1).bytes),
                maxLength: 1);
            
            //TODO: reference implementation contains additional (nameprinted)
            // check, but i think its redundant
            
            //length of attribute name (2 bytes)
            var attrname_len : UInt16 = CFSwapInt16HostToBig((UInt16)(count(attrname)));
            stream.write(UnsafePointer(NSData(bytes: &attrname_len, length: 2).bytes),
                maxLength: 2);
            //value of attribute name
            stream.write(attrname,
                maxLength: count(attrname));
            
            
            if ( prop.propertyType == Property.INTEGER || prop.propertyType == Property.ENUM ){
                //2 bytes of data length
                var typeIntEnum = CFSwapInt16HostToBig(0x0004);
                stream.write(UnsafePointer(NSData(bytes: &typeIntEnum, length: 2).bytes),
                    maxLength: 2);
                //4 more bytes of actual data
                var data_big = CFSwapInt32HostToBig(prop.getInt32());
                stream.write(UnsafePointer(NSData(bytes: &data_big, length: 4).bytes),
                    maxLength: 4);

            }else if(prop.propertyType == Property.BOOLEAN){
                //2 bytes of data length
                var typeIntEnum = CFSwapInt16HostToBig(0x0001);
                stream.write(UnsafePointer(NSData(bytes: &typeIntEnum, length: 2).bytes),
                    maxLength: 2);
                //1 byte of boolean value
                var offr = prop.getInt32();
                stream.write(UnsafePointer(NSData(bytes: &offr, length: 1).bytes),
                    maxLength: 1);
            }else{
                
                var truelen = count(prop.getString());
                var edianlen : UInt16 = CFSwapInt16HostToBig((UInt16)(count(prop.getString())));
                
                //2 bytes of data length
                stream.write(UnsafePointer(NSData(bytes: &edianlen, length: 2).bytes),
                    maxLength: 2);
                
                //X bytes of data
                var NV = NSData(bytes: prop.getString(), length: truelen).bytes;
                stream.write(UnsafePointer(NV),
                    maxLength: truelen);
            }
            
        }
        
        stream.write(UnsafePointer(NSData(bytes: &tags["end-of-attributes-tag"], length: 1).bytes),
            maxLength: 1);
        
        stream.close();
        //end of attrs
        
        /*if(self.data.length == 0){
            buffer.append(self.data.bytes);
        }*/
        return NSData(bytes: xbuffer, length: xbuffer.count);
    }
}