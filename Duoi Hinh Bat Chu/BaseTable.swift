//
//  BaseTable.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/29/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit

class BaseTable: NSObject {
    var documents:NSURL!
    var fileURL:NSURL!
    var database :FMDatabase!
    override init() {
        // set myValue before super.init is called
        super.init()
               
        documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        fileURL = documents.URLByAppendingPathComponent("database.sqlite")
        database = FMDatabase(path: fileURL.path)
        
        if !database.open() {
            print("Unable to open database")
            return
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
