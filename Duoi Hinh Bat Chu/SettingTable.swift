//
//  SettingTable.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 8/25/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit

class SettingTable: BaseTable {
    
    private var TABLE_NAME:String="setting";
    private var SOUND="sound"

    private var ID="id"
    
    func getAll()->SettingDTO{
        var dto:SettingDTO!

        let sql="select *from " + TABLE_NAME ;
        do {
            
            let s = try database.executeQuery(sql, values: nil)
            while s.next() {
                 dto = SettingDTO()
                dto.id=Int(s.intForColumn(ID))
               dto.sound=s.boolForColumn(SOUND)
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
        return dto
    }
    /*
    update table
    */
    func updateTable(dto:SettingDTO){
        do {
            let sql="update setting set sound=? where id=?"
            try database.executeUpdate(sql, values: [dto.sound, dto.id])
            
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
        
    }
    

    

}
