//
//  Validates.swift
//  ValidateCheckTest
//
//  Created by ImaedaToshiharu on 2016/07/12.
//  Copyright © 2016年 ImaedaToshiharu All rights reserved.
//

import UIKit

class Validates: NSObject {
    
    /**
     * 住所判定
     */
    class func checkAddress(str:String) -> Result {
        let result:Result = Result()
        do {
            let pattern:String = "^.{0,30}$"
            let regexp:NSRegularExpression = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regexp.matchesInString(str, options: [], range: NSMakeRange(0, str.characters.count))
            if matches.count == 0 {
                // アウト
                result.result = false
                result.message = "入力できるのは30文字までです"
            }
        } catch let error as NSError {
            result.result = false
            print(error)
        }
        return result
    }
    
    /**
     * メールアドレス判定
     */
    class func checkMail(str:String) -> Result {
        let result:Result = Result()
        do {
            let pattern:String = "^(|[a-zA-Z0-9\\._-]*@[a-zA-Z0-9\\._-]+)$"
            let regexp:NSRegularExpression = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regexp.matchesInString(str, options: [], range: NSMakeRange(0, str.characters.count))
            if matches.count == 0 {
                // アウト
                result.result = false
                result.message = "メールアドレスが正しくありません"
            } else if str.characters.count > 45 {
                // アウト
                result.result = false
                result.message = "入力できるのは45文字までです"
            }
        } catch let error as NSError {
            result.result = false
            print(error)
        }
        return result
    }
    
    /**
     * 半角入力チェック
     */
    class func checkHalfSizeInput(str:String) -> Result {
        let result:Result = Result()
        let nsStringlen:Int = str.characters.count
        let utf8 = (str as NSString).UTF8String
        // Cのstrlenは全角を2で判定する
        let cStringlen = Int(bitPattern: strlen(utf8))
        if nsStringlen != cStringlen {
            result.result = false
            result.message = "入力できるのは半角のみです"
        }
        return result
    }
}
