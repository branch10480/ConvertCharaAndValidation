//
//  ViewController.swift
//  ValidateCheckTest
//
//  Created by ImaedaToshiharu on 2016/07/12.
//  Copyright © 2016年 ImaedaToshiharu All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyTextFieldDelegate {
    
    @IBOutlet weak var textField01: MyTextField!
    @IBOutlet weak var forConvertFullSize: MyTextField!
    @IBOutlet weak var forConvertToKatakana: MyTextField!
    @IBOutlet weak var mailAddress: MyTextField!
    @IBOutlet weak var onlyHalfSizeInput: MyTextField!
    
    var activeResponder:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲート設定
        self.textField01.myDelegate = self
        self.forConvertFullSize.myDelegate = self
        self.forConvertToKatakana.myDelegate = self
        self.mailAddress.myDelegate = self
        self.onlyHalfSizeInput.myDelegate = self
        
        self.textField01.type = "address"
        self.forConvertFullSize.type = "address"
        self.forConvertToKatakana.type = "katakana"
        self.mailAddress.type = "mail"
        self.onlyHalfSizeInput.type = ""
        
        self.textField01.format = 0
        self.forConvertFullSize.format = 2
        self.forConvertToKatakana.format = 2
        self.mailAddress.format = 1
        self.onlyHalfSizeInput.format = 1
        
        self.mailAddress.maxCount = 45
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapBGView(sender: AnyObject) {
        if self.activeResponder != nil {
            self.activeResponder?.resignFirstResponder()
        }
    }
    
    // MARK: - MyTextFieldDelegate

    func openAlert(message:String) {
        
        let ac = UIAlertController.init(title: "", message: message, preferredStyle: .Alert)
        let action:UIAlertAction = UIAlertAction.init(title: "OK", style: .Default, handler: nil)
        ac.addAction(action)
        self.presentViewController(ac, animated: true, completion: nil)
    }

    func setAResponder(textField: UITextField) {
        if self.activeResponder != nil {
            self.activeResponder?.resignFirstResponder()
        }
        self.activeResponder = textField
    }
    
    func removeAResponder(textField: UITextField) {
        if self.activeResponder != nil {
            self.activeResponder?.resignFirstResponder()
        }
        self.activeResponder = nil
    }
}

