//
//  AVCaptureDeviceExtensions.swift
//  Recoger
//
//  Created by won on 01/02/2018.
//  Copyright © 2018 Won. All rights reserved.
//

import AVFoundation

extension AVCaptureDevice {
    
    static var defaultVideoDevice: AVCaptureDevice? {
        // Choose the back dual camera if available, otherwise default to a wide angle camera.
        
        if let dualCameraDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInDualCamera,
                                                          for: AVMediaType.video, position: .back) {
            return dualCameraDevice
        } else if let backCameraDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                                                                 for: AVMediaType.video, position: .back) {
            // If the back dual camera is not available, default to the back wide angle camera.
            return backCameraDevice
        } else if let frontCameraDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                                                                  for: AVMediaType.video, position: .front) {
            // In some cases where users break their phones, the back wide angle camera is not available. In this case, we should default to the front wide angle camera.
            return frontCameraDevice
        }
        
        return nil
    }
}
