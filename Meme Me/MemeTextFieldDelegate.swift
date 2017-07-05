//
//  MemeTextFieldDelegate.swift
//  Meme Me
//
//  Created by Ken Westdorp on 7/4/17.
//
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {

    //clears text field when editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
