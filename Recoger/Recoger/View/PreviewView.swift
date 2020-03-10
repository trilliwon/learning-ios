//
//  AppDelegate.swift
//  Recoger
//
//  Created by Won on 07/05/2017.
//  Copyright © 2017 Won. All rights reserved.
//

import UIKit
import AVFoundation

class PreviewView: UIView {

	// MARK: Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
		setNeedsLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	// MARK: AV capture properties
	var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        
		guard let layer = layer as? AVCaptureVideoPreviewLayer else { fatalError() }
		return layer
	}

	var session: AVCaptureSession? {
		get {
			return videoPreviewLayer.session
		}

		set{
			videoPreviewLayer.session = newValue
		}
	}

	// MARK: UIView
	override class var layerClass: AnyClass {
		return AVCaptureVideoPreviewLayer.self
	}
}
