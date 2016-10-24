//
//  TrollTable.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/29/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit
class TrollTable: BaseTable {
    private var TABLE_NAME:String="troll_question";
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
//    func insertTable(){
//
//        do {
//            try database.executeUpdate("create table test(x text, y text, z text)", values: nil)
//            try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["a", "b", "c"])
//            try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["e", "f", "g"])
//            
//            let rs = try database.executeQuery("select x, y, z from test", values: nil)
//            while rs.next() {
//                let x = rs.stringForColumn("x")
//                let y = rs.stringForColumn("y")
//                let z = rs.stringForColumn("z")
//                print("x = \(x); y = \(y); z = \(z)")
//            }
//        } catch let error as NSError {
//            print("failed: \(error.localizedDescription)")
//        }
//        
//        database.close()
//    }
}
