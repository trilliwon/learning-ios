//
//  UIButtonExtensions.swift
//  CodeReader
//
//  Created by Won on 07/05/2017.
//  Copyright © 2017 Won. All rights reserved.
//

import UIKit

extension UITextField {
	func setupDoneButtonOnKeyboardToolBar(title: String? = nil) {
		let keyboardToolbar = UIToolbar()
		keyboardToolbar.isTranslucent = true
		keyboardToolbar.sizeToFit()

		let doneButton = UIBarButtonItem(title: title ?? "OK", style: .plain, target: self, action: #selector(self.resignFirstResponder))
		doneButton.tintColor = UIColor.bitBlueColor
		let flexItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		keyboardToolbar.items = [flexItem, doneButton]
		self.inputAccessoryView = keyboardToolbar
	}
}
