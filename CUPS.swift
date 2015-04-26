//
//  CUPS.swift
//  UPrint DST (Distributed)
//
//  Created by Pat Sabpisal on 4/20/15.
//  Copyright (c) 2015 Pat Sabpisal. All rights reserved.
//

import Foundation

public class CUPS {
     var IPP_PORT = 631;
    
     var IPP_MAX_NAME = 256;
     var IPP_MAX_VALUES = 8;
    
    
     var IPP_TAG_ZERO  = 0x00;
     var IPP_TAG_OPERATION = 0x01;
     var IPP_TAG_JOB = 0x02;
     var IPP_TAG_END = 0x03;
     var IPP_TAG_PRINTER = 0x04;
     var IPP_TAG_UNSUPPORTED_GROUP = 0x05;
     var IPP_TAG_SUBSCRIPTION = 0x06;
     var IPP_TAG_EVENT_NOTIFICATION = 0x07;
     var IPP_TAG_UNSUPPORTED_VALUE = 0x10;
     var IPP_TAG_DEFAULT = 0x11;
     var IPP_TAG_UNKNOWN = 0x12;
     var IPP_TAG_NOVALUE = 0x13;
     var IPP_TAG_NOTSETTABLE = 0x15;
     var IPP_TAG_DELETEATTR = 0x16;
     var IPP_TAG_ADMINDEFINE = 0x17;
     var IPP_TAG_INTEGER = 0x21;
     var IPP_TAG_BOOLEAN = 0x22;
     var IPP_TAG_ENUM = 0x23;
     var IPP_TAG_STRING = 0x30;
     var IPP_TAG_DATE = 0x31;
     var IPP_TAG_RESOLUTION = 0x32;
     var IPP_TAG_RANGE = 0x33;
     var IPP_TAG_BEGIN_COLLECTION = 0x34;
     var IPP_TAG_TEXTLANG = 0x35;
     var IPP_TAG_NAMELANG = 0x36;
     var IPP_TAG_END_COLLECTION = 0x37;
     var IPP_TAG_TEXT = 0x41;
     var IPP_TAG_NAME = 0x42;
     var IPP_TAG_KEYWORD = 0x44;
     var IPP_TAG_URI = 0x45;
     var IPP_TAG_URISCHEME = 0x46;
     var IPP_TAG_CHARSET = 0x47;
     var IPP_TAG_LANGUAGE = 0x48;
     var IPP_TAG_MIMETYPE = 0x49;
     var IPP_TAG_MEMBERNAME = 0x4a;
     var IPP_TAG_MASK = 0x7fffffff;
     var IPP_TAG_COPY = -0x7fffffff-1;
    
    
     var IPP_RES_PER_INCH = 3;
     var IPP_RES_PER_CM = 4;
    
     var IPP_FINISHINGS_NONE = 3;
     var IPP_FINISHINGS_STAPLE = 4;
     var IPP_FINISHINGS_PUNCH = 5;
     var IPP_FINISHINGS_COVER = 6;
     var IPP_FINISHINGS_BIND = 7;
     var IPP_FINISHINGS_SADDLE_STITCH = 8;
     var IPP_FINISHINGS_EDGE_STITCH = 9;
     var IPP_FINISHINGS_FOLD = 10;
     var IPP_FINISHINGS_TRIM = 11;
     var IPP_FINISHINGS_BALE = 12;
     var IPP_FINISHINGS_BOOKLET_MAKER = 13;
     var IPP_FINISHINGS_JOB_OFFSET = 14;
     var IPP_FINISHINGS_STAPLE_TOP_LEFT = 20;
     var IPP_FINISHINGS_STAPLE_BOTTOM_LEFT = 21;
     var IPP_FINISHINGS_STAPLE_TOP_RIGHT = 22;
     var IPP_FINISHINGS_STAPLE_BOTTOM_RIGHT = 23;
     var IPP_FINISHINGS_EDGE_STITCH_LEFT = 24;
     var IPP_FINISHINGS_EDGE_STITCH_TOP = 25;
     var IPP_FINISHINGS_EDGE_STITCH_RIGHT = 26;
     var IPP_FINISHINGS_EDGE_STITCH_BOTTOM = 27;
     var IPP_FINISHINGS_STAPLE_DUAL_LEFT = 28;
     var IPP_FINISHINGS_STAPLE_DUAL_TOP = 29;
     var IPP_FINISHINGS_STAPLE_DUAL_RIGHT = 30;
     var IPP_FINISHINGS_STAPLE_DUAL_BOTTOM = 31;
     var IPP_FINISHINGS_BIND_LEFT = 50;
     var IPP_FINISHINGS_BIND_TOP = 51;
     var IPP_FINISHINGS_BIND_RIGHT = 52;
     var IPP_FINISHINGS_BIND_BOTTO = 53;
    
     var IPP_PORTRAIT = 3;
     var IPP_LANDSCAPE = 4;
     var IPP_REVERSE_LANDSCAPE = 5;
     var IPP_REVERSE_PORTRAIT = 6;
    
     var IPP_QUALITY_DRAFT = 3;
     var IPP_QUALITY_NORMAL = 4;
     var IPP_QUALITY_HIGH = 5;
    
     var IPP_JOB_PENDING = 3;
     var IPP_JOB_HELD = 4;
     var IPP_JOB_PROCESSING = 5;
     var IPP_JOB_STOPPED = 6;
     var IPP_JOB_CANCELLED = 7;
     var IPP_JOB_ABORTED = 8;
     var IPP_JOB_COMPLETE = 9;
    
     var IPP_PRINTER_IDLE = 3;
     var IPP_PRINTER_PROCESSING = 4;
     var IPP_PRINTER_STOPPED = 5;
    
     var IPP_ERROR = -1;
     var IPP_IDLE = 0;
     var IPP_HEADER = 1;
     var IPP_ATTRIBUTE = 2;
     var IPP_DATA = 3;
    
     var IPP_PRINT_JOB = 0x0002;
     var IPP_PRINT_URI = 0x0003;
     var IPP_VALIDATE_JOB = 0x0004;
     var IPP_CREATE_JOB = 0x0005;
     var IPP_SEND_DOCUMENT = 0x0006;
     var IPP_SEND_URI = 0x0007;
     var IPP_CANCEL_JOB = 0x0008;
     var IPP_GET_JOB_ATTRIBUTES = 0x0009;
     var IPP_GET_JOBS = 0x000a;
     var IPP_GET_PRINTER_ATTRIBUTES = 0x000b;
     var IPP_HOLD_JOB = 0x000c;
     var IPP_RELEASE_JOB = 0x000d;
     var IPP_RESTART_JOB = 0x000e;
     var IPP_PAUSE_PRINTER = 0x0010;
     var IPP_RESUME_PRINTER = 0x0011;
     var IPP_PURGE_JOBS = 0x0012;
     var IPP_SET_PRINTER_ATTRIBUTES = 0x0013;
     var IPP_SET_JOB_ATTRIBUTES = 0x0014;
     var IPP_GET_PRINTER_SUPPORTED_VALUES = 0x0015;
     var IPP_CREATE_PRINTER_SUBSCRIPTION = 0x0016;
     var IPP_CREATE_JOB_SUBSCRIPTION = 0x0017;
     var IPP_GET_SUBSCRIPTION_ATTRIBUTES = 0x0018;
     var IPP_GET_SUBSCRIPTIONS = 0x0019;
     var IPP_RENEW_SUBSCRIPTION = 0x001a;
     var IPP_CANCEL_SUBSCRIPTION = 0x001b;
     var IPP_GET_NOTIFICATIONS = 0x001c;
     var IPP_SEND_NOTIFICATIONS = 0x001d;
     var IPP_GET_PRINT_SUPPORT_FILES = 0x0021;
     var IPP_ENABLE_PRINTER = 0x0022;
     var IPP_DISABLE_PRINTER = 0x0023;
     var IPP_PAUSE_PRINTER_AFTER_CURRENT_JOB = 0x0024;
     var IPP_HOLD_NEW_JOBS = 0x0025;
     var IPP_RELEASE_HELD_NEW_JOBS = 0x0026;
     var IPP_DEACTIVATE_PRINTER = 0x0027;
     var IPP_ACTIVATE_PRINTER = 0x0028;
     var IPP_RESTART_PRINTER = 0x0029;
     var IPP_SHUTDOWN_PRINTER = 0x002a;
     var IPP_STARTUP_PRINTER = 0x002b;
     var IPP_REPROCESS_JOB = 0x002c;
     var IPP_CANCEL_CURRENT_JOB = 0x002d;
     var IPP_SUSPEND_CURRENT_JOB = 0x002e;
     var IPP_RESUME_JOB = 0x002f;
     var IPP_PROMOTE_JOB = 0x0030;
     var IPP_SCHEDULE_JOB_AFTER = 0x0031;
     var IPP_PRIVATE = 0x4000;
    
     var CUPS_GET_DEFAULT : UInt16 = 0x4001;
     var CUPS_GET_PRINTERS : UInt16 = 0x4002;
     var CUPS_ADD_PRINTER : UInt16 = 0x4003;
     var CUPS_DELETE_PRINTER : UInt16 = 0x4004;
     var CUPS_GET_CLASSES : UInt16 = 0x4005;
     var CUPS_ADD_CLASS : UInt16 = 0x4006;
     var CUPS_DELETE_CLASS : UInt16 = 0x4007;
     var CUPS_ACCEPT_JOBS : UInt16 = 0x4008;
     var CUPS_REJECT_JOBS : UInt16 = 0x4009;
     var CUPS_SET_DEFAULT : UInt16 = 0x400a;
     var CUPS_GET_DEVICES : UInt16 = 0x400b;
     var CUPS_GET_PPDS : UInt16 = 0x400c;
     var CUPS_MOVE_JOB : UInt16 = 0x400d;
     var CUPS_AUTHENTICATE_JOB : UInt16 = 0x400e;
    
     var IPP_OK = 0x0000;
     var IPP_OK_SUBST = 0x0001;
     var IPP_OK_CONFLICT = 0x0002;
     var IPP_OK_IGNORED_SUBSCRIPTIONS = 0x0003;
     var IPP_OK_IGNORED_NOTIFICATIONS = 0x0004;
     var IPP_OK_TOO_MANY_EVENTS = 0x0005;
     var IPP_OK_BUT_CANCEL_SUBSCRIPTION = 0x0006;
     var IPP_REDIRECTION_OTHER_SITE = 0x0300;
     var IPP_BAD_REQUEST = 0x0400;
     var IPP_FORBIDDEN = 0x0401;
     var IPP_NOT_AUTHENTICATED = 0x0402;
     var IPP_NOT_AUTHORIZED = 0x0403;
     var IPP_NOT_POSSIBLE = 0x0404;
     var IPP_TIMEOUT = 0x0405;
     var IPP_NOT_FOUND = 0x0406;
     var IPP_GONE = 0x0407;
     var IPP_REQUEST_ENTITY = 0x0408;
     var IPP_REQUEST_VALUE = 0x0409;
     var IPP_DOCUMENT_FORMAT = 0x040a;
     var IPP_ATTRIBUTES = 0x040b;
     var IPP_URI_SCHEME = 0x040c;
     var IPP_CHARSET = 0x040d;
     var IPP_CONFLICT = 0x040e;
     var IPP_COMPRESSION_NOT_SUPPORTED = 0x040f;
     var IPP_COMPRESSION_ERROR = 0x0410;
     var IPP_DOCUMENT_FORMAT_ERROR = 0x0411;
     var IPP_DOCUMENT_ACCESS_ERROR = 0x0412;
     var IPP_ATTRIBUTES_NOT_SETTABLE = 0x0413;
     var IPP_IGNORED_ALL_SUBSCRIPTIONS = 0x0414;
     var IPP_TOO_MANY_SUBSCRIPTIONS = 0x0415;
     var IPP_IGNORED_ALL_NOTIFICATIONS = 0x0416;
     var IPP_PRINT_SUPPORT_FILE_NOT_FOUND = 0x0417;
    
     var IPP_INTERNAL_ERROR = 0x0500;
     var IPP_OPERATION_NOT_SUPPORTED = 0x0501;
     var IPP_SERVICE_UNAVAILABLE = 0x0502;
     var IPP_VERSION_NOT_SUPPORTED = 0x0503;
     var IPP_DEVICE_ERROR = 0x0504;
     var IPP_TEMPORARY_ERROR = 0x0505;
     var IPP_NOT_ACCEPTING = 0x0506;
     var IPP_PRINTER_BUSY = 0x0507;
     var IPP_ERROR_JOB_CANCELLED = 0x0508;
     var IPP_MULTIPLE_JOBS_NOT_SUPPORTED = 0x0509;
     var IPP_PRINTER_IS_DEACTIVATED = 0x50a;
    
     var CUPS_PRINTER_LOCAL = 0x0000;
     var CUPS_PRINTER_CLASS : UInt16 = 0x0001;
     var CUPS_PRINTER_REMOTE = 0x0002;
     var CUPS_PRINTER_BW = 0x0004;
     var CUPS_PRINTER_COLOR = 0x0008;
     var CUPS_PRINTER_DUPLEX = 0x0010;
     var CUPS_PRINTER_STAPLE = 0x0020;
     var CUPS_PRINTER_COPIES = 0x0040;
     var CUPS_PRINTER_COLLATE = 0x0080;
     var CUPS_PRINTER_PUNCH = 0x0100;
     var CUPS_PRINTER_COVER = 0x0200;
     var CUPS_PRINTER_BIND = 0x0400;
     var CUPS_PRINTER_SORT = 0x0800;
     var CUPS_PRINTER_SMALL = 0x1000;
     var CUPS_PRINTER_MEDIUM = 0x2000;
     var CUPS_PRINTER_LARGE = 0x4000;
     var CUPS_PRINTER_VARIABLE = 0x8000;
     var CUPS_PRINTER_IMPLICIT = 0x1000;
     var CUPS_PRINTER_DEFAULT = 0x2000;
     var CUPS_PRINTER_FAX = 0x4000;
     var CUPS_PRINTER_REJECTING = 0x8000;
     var CUPS_PRINTER_DELETE = 0x1000;
     var CUPS_PRINTER_NOT_SHARED = 0x2000;
     var CUPS_PRINTER_AUTHENTICATED = 0x4000;
     var CUPS_PRINTER_COMMANDS = 0x8000;
     var CUPS_PRINTER_OPTIONS = 0xe6ff;
    
     var charset : String = "utf-8";
     var language : String = "en-us";
     var requestId : UInt32 = 0;
    
     var username : String = "";
     var password : String = "";
     var url : NSURL;
    
    init(url: NSURL){
        if(url.scheme == "ipp"){
            //set it to http
        }
        NSLog("Will connect %@", url);
        self.url = url;
    }
    
    func send(iprq: IPPMessage, callback: (IPPMessage!) -> Void) {
        var request = NSMutableURLRequest(URL: self.url)
        var session = NSURLSession.sharedSession()
        var err: NSError?
        
        request.HTTPMethod = "POST"
        var msg : IPPMessage?;
        //Add header Content-Type: application/ipp
        request.addValue("application/ipp", forHTTPHeaderField: "Content-Type");
        //Make HTTP Request with data stream = IPPRequest dump
        request.HTTPBody = iprq.dump();
        //Get Response
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            println("Data: \(data)")
            let httpResp: NSHTTPURLResponse = response as! NSHTTPURLResponse;
            if(httpResp.statusCode == 403){
                NSLog("Forbidden!");
                return;
            }
            msg = IPPMessage(serializeddata: data);
            callback(msg);
            
        });
        task.resume()
    }
    
    func getPrinters(){
        var m = IPPMessage(OpID: CUPS_GET_PRINTERS, requestID: 0x0000);
        
        m.setOperationAttribute("attributes-charset", prop: Property(prop: "charset",value: "utf-8"));
        m.setOperationAttribute("attributes-natural-language", prop: Property(prop: "naturalLanguage",value: "en-us"));

        m.setOperationAttribute("requested-attributes", prop: Property(prop: "keyword",value: "printer-name"));
        m.setOperationAttribute("printer-type", prop: Property(prop: Property.ENUM, value: 0));
        m.setOperationAttribute("printer-type-mask", prop: Property(prop: Property.ENUM, value: (UInt32)(CUPS_PRINTER_CLASS)));
    
        NSLog("Request %@", m.dump());
        
        send(m, callback: { response in
           println(response.attributes[IPPMessage.PRINTER_ATTRIBUTES]);
        });
        
    }
    
    func getNextRequestId() -> UInt32{
        self.requestId += 1 ;
        return self.requestId;
    }
}