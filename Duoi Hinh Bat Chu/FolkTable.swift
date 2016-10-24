//
//  FolkTable.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/30/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit

class FolkTable: BaseTable {
    private var TABLE_NAME:String="folk_question";
    private var THE_LOAI="theloai"
    private var CAU_HOI="cauhoi"
    private var DAP_AN_DUNG="dapandung"
    private var DAP_AN_CUOI_CUNG="dapancuoicung"
    private var ID="id"
    func getAll()->Array<QuestionDTO>{
        var array:Array<QuestionDTO>=Array()
        let sql="select *from " + TABLE_NAME ;
        do {
            
            let s = try database.executeQuery(sql, values: nil)
            while s.next() {
                let dto:QuestionDTO = QuestionDTO()
                dto.id=Int(s.intForColumn(ID))
                dto.theLoai=s.stringForColumn(THE_LOAI)
                dto.cauHoi=s.stringForColumn(CAU_HOI)
                dto.dapAn=s.stringForColumn(DAP_AN_DUNG)
                dto.dapAnCuoiCung=s.stringForColumn(DAP_AN_CUOI_CUNG)
                array.append(dto)
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
        return array
    }

}
