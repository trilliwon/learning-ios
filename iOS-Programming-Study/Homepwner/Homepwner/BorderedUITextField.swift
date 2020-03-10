//
//  BorderedUITextField.swift
//  Homepwner
//
//  Created by WON on 12/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

class BorderedUITextField: UITextField {

    override func becomeFirstResponder() -> Bool {
        let becomeFirstResponder = super.becomeFirstResponder()
        if becomeFirstResponder {
            borderStyle = .bezel
        }
        return becomeFirstResponder
    }

    override func resignFirstResponder() -> Bool {
        let resignFirstResponder = super.resignFirstResponder()
        if resignFirstResponder {
            borderStyle = .roundedRect
        }
        return resignFirstResponder
    }
}
