//
//  ROLRegisterController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/21.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLRegisterController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    // MARK: - private
    // MARK: setup
    private func setup() {
        self.usernameTextField.textAlignment = NSTextAlignment.Center
        self.usernameTextField.textColor = UIColor.black50PercentColor()
        self.usernameTextField.font = UIFont.systemFontOfSize(18)
        self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "用户名", attributes: [NSForegroundColorAttributeName: UIColor(white: 0.836, alpha: 1), NSFontAttributeName: UIFont.italicSystemFontOfSize(18)])
        self.usernameTextField.keyboardType = UIKeyboardType.EmailAddress
        self.usernameTextField.returnKeyType = UIReturnKeyType.Next
        self.usernameTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.usernameTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.usernameTextField.rightViewMode = UITextFieldViewMode.WhileEditing
        
        self.emailTextField.textAlignment = NSTextAlignment.Center
        self.emailTextField.textColor = UIColor.black50PercentColor()
        self.emailTextField.font = UIFont.systemFontOfSize(18)
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "邮箱", attributes: [NSForegroundColorAttributeName: UIColor(white: 0.836, alpha: 1), NSFontAttributeName: UIFont.italicSystemFontOfSize(18)])
        self.emailTextField.keyboardType = UIKeyboardType.EmailAddress
        self.emailTextField.returnKeyType = UIReturnKeyType.Next
        self.emailTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.emailTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.emailTextField.rightViewMode = UITextFieldViewMode.WhileEditing
        
        self.passwordTextField.textAlignment = NSTextAlignment.Center
        self.passwordTextField.font = UIFont.systemFontOfSize(18)
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "密码", attributes: [NSForegroundColorAttributeName: UIColor(white: 0.836, alpha: 1), NSFontAttributeName: UIFont.italicSystemFontOfSize(18)])
        self.passwordTextField.secureTextEntry = true
        self.passwordTextField.keyboardType = UIKeyboardType.ASCIICapable
        self.passwordTextField.returnKeyType = UIReturnKeyType.Go
        self.passwordTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.passwordTextField.autocorrectionType = UITextAutocorrectionType.No
        self.passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.passwordTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.passwordTextField.rightViewMode = UITextFieldViewMode.WhileEditing
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: notification
    func keyboardWillShow(noti: NSNotification) {
        // frame
        var keyboardF = noti.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        
        // duration
        var duration = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        // animate
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.view.transform = CGAffineTransformMakeTranslation(0, -50)
            }, completion: nil)
    }
    
    func keyboardWillHide(noti: NSNotification) {
        // duration
        var duration = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        // animate
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.view.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    // MARK: hide statusBar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    // MARK: - actions
    @IBAction func laterRegisterBtnClicked(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func registerBtnClicked(sender: UIButton) {
        self.view.endEditing(true)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        SEProgressHUDTool.showMessage("注册中...", toView: self.view)
        
        ROLUserInfoManager.sharedManager.registerUser(self.usernameTextField.text, password: self.passwordTextField.text, email: self.emailTextField.text, success: { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                SEProgressHUDTool.hideHUDForView(self.view)
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }) { (code) -> Void in
            if code == 202 {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    SEProgressHUDTool.hideHUDForView(self.view)
                    self.view.makeToast("该用户名已经被使用", duration: 3, position: CSToastPositionBottom, title: "注册失败")
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    SEProgressHUDTool.hideHUDForView(self.view)
                    self.view.makeToast("请检查邮箱是否正确", duration: 3, position: CSToastPositionBottom, title: "注册失败")
                })
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
