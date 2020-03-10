//
//  GeneratorViewController.swift
//  CodeReader
//
//  Created by Won on 06/05/2017.
//  Copyright © 2017 Won. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GeneratorViewController: UIViewController {

	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var imgQRCode: UIImageView!
	@IBOutlet weak var generateButton: UIButton!

	var qrcodeImage: CIImage!
	let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(changeScale(recognizer:))))
		self.textField.setupDoneButtonOnKeyboardToolBar()

        textField.rx.text
            .orEmpty
            .share(replay: 1)
            .subscribe(onNext: { text in
			self.generateButton.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: text != "" ? 1 : 0.5).cgColor
			self.generateButton.isEnabled = text != ""
		}).disposed(by: disposeBag)
	}

    @objc func changeScale(recognizer: UIPinchGestureRecognizer) {
		switch recognizer.state {
		case .changed, .ended:
			if recognizer.scale < 2 && recognizer.scale > 0.5 {
				imgQRCode.transform = CGAffineTransform(scaleX: recognizer.scale, y: recognizer.scale)
			}
		default:
			break
		}
	}
    
	// MARK: IBAction method implementation
	@IBAction func performButtonAction(_ sender: AnyObject) {
		if qrcodeImage == nil {
			if textField.text == "" { return }

			let data = textField.text!.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)

			guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return }
			filter.setValue(data, forKey: "inputMessage")
			filter.setValue("Q", forKey: "inputCorrectionLevel")

			qrcodeImage = filter.outputImage
			generateButton.setTitle("Clear", for: UIControlState())
			textField.resignFirstResponder()
			displayQRCodeImage()
		}
		else {
			imgQRCode.image = nil
			qrcodeImage = nil
			generateButton.setTitle("Generate", for: UIControlState())
		}

		textField.isEnabled = !textField.isEnabled
	}

	// MARK: Custom method implementation
	func displayQRCodeImage() {
		let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
		let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height

		let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
		imgQRCode.image = UIImage(ciImage: transformedImage)
	}
}
