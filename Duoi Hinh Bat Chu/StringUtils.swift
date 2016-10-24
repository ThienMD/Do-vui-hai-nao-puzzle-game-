//
//  StringUtils.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/24/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit

class StringUtils: NSObject {
    func randomAlphaNumericString(length: Int) -> String {
        
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    func randomAlphaNumericCharacter() -> Character {
        
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        let randomNum = Int(arc4random_uniform(allowedCharsCount))
        let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
 
        return newCharacter
    }
    func arrayCharacterFromString(str:String)->Array<String>{
        let splitedFullName = str.componentsSeparatedByString("")
        return splitedFullName
    }
}
