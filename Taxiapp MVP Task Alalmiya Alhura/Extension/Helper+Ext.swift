
//  Helper+Ext.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//


import Foundation
import UIKit
import SafariServices
 extension  UIViewController {
    
    // AlertController An action that can be show message  in an alert.
     func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

   
}

