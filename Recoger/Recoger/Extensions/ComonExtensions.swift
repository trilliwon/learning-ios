//
//  ComonExtentions.swift
//  CodeReader
//
//  Created by Won on 06/05/2017.
//  Copyright © 2017 Won. All rights reserved.
//

import UIKit
import AVFoundation

@available(iOS 10.0, *)
extension AVCaptureDevice.DiscoverySession {
	func uniqueDevicePositionsCount() -> Int {
		var uniqueDevicePositions = [AVCaptureDevice.Position]()

		for device in devices {
			if !uniqueDevicePositions.contains(device.position) {
				uniqueDevicePositions.append(device.position)
			}
		}

		return uniqueDevicePositions.count
	}
}

extension UIDeviceOrientation {
	var videoOrientation: AVCaptureVideoOrientation? {
		switch self {
		case .portrait: return .portrait
		case .portraitUpsideDown: return .portraitUpsideDown
		case .landscapeLeft: return .landscapeRight
		case .landscapeRight: return .landscapeLeft
		default: return nil
		}
	}
}

extension UIInterfaceOrientation {
	var videoOrientation: AVCaptureVideoOrientation? {
		switch self {
		case .portrait: return .portrait
		case .portraitUpsideDown: return .portraitUpsideDown
		case .landscapeLeft: return .landscapeLeft
		case .landscapeRight: return .landscapeRight
		default: return nil
		}
	}
}
