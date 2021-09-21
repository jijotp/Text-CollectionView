//
//  ViewController.swift
//  Test
//
//  Created by Jijo on 16/08/21.
//

import UIKit
import WebKit
class ViewController: UIViewController {

    @IBOutlet weak var topconstraint: NSLayoutConstraint!
    @IBOutlet weak var akdadajdd: WKWebView!
    override func viewDidLoad() {
        addObserver()
       
    }


    @IBAction func onCLick(_ sender: Any) {
        topconstraint.constant = 200
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension UIViewController {
    
    /// Add observer for keyboard
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    /// Remove Keyboard Observer
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK:- Keyboard Animation -
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        self.view.setNeedsLayout()
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: [.curveEaseInOut], animations: {
            let info = notification.userInfo!
            let inputViewFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let screenSize = UIScreen.main.bounds
            var frame = self.view.frame
            frame.size.height = screenSize.height - inputViewFrame.size.height
            self.view.frame = frame
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        self.view.setNeedsLayout()
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: [.curveEaseInOut], animations: {
            let screenSize = UIScreen.main.bounds
            var frame = self.view.frame
            frame.size.height = screenSize.height
            self.view.frame = frame
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
