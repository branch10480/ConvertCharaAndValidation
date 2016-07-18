//
//  MyTextField.swift
//  ValidateCheckTest
//
//  Created by ImaedaToshiharu on 2016/07/12.
//  Copyright © 2016年 ImaedaToshiharu All rights reserved.
//

import UIKit

@objc protocol MyTextFieldDelegate {
    func openAlert(message:String) -> Void
    func setAResponder(textField:UITextField) -> Void
    func removeAResponder(textField:UITextField) -> Void
}

class MyTextField: UITextField, UITextFieldDelegate {

    var myDelegate:MyTextFieldDelegate!
    var type:String = ""
    var format:Int = 0
    var maxCount = -1
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        self.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if self.delegate != nil {
            self.myDelegate.setAResponder(self)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if self.delegate != nil {
            self.myDelegate.removeAResponder(self)
        }
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        print("通りました")
        
        var result:Result = Result()
        
        // 全角、半角変換
        switch self.format {
        case 0:
            // 指定なし
            break
        case 1:
            // 半角のみ
            let str:NSMutableString = NSMutableString(string:textField.text!)
            CFStringTransform(str, nil, kCFStringTransformFullwidthHalfwidth, false)
            textField.text = str as String
            result = Validates.checkHalfSizeInput(textField.text!)
            break
        case 2:
            // 全角のみ
            let str:NSMutableString = NSMutableString(string:textField.text!)
            CFStringTransform(str, nil, kCFStringTransformFullwidthHalfwidth, true)
            textField.text = str as String
            break
        default:
            break
        }
        if !result.result {
            self.myDelegate.openAlert(result.message)
            return result.result
        }
        
        // テキストタイプ
        switch self.type {
        case "address":
            result = Validates.checkAddress(textField.text!)
            break
        case "katakana":
            let str:NSMutableString = NSMutableString(string:textField.text!)
            CFStringTransform(str, nil, kCFStringTransformHiraganaKatakana, false)
            textField.text = str as String
            break
        case "mail":
            result = Validates.checkMail(textField.text!)
            break
        default:
            break
        }
        
        if !result.result {
            self.myDelegate.openAlert(result.message)
        }
        return result.result
    }
}
