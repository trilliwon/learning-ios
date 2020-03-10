//
//  ReaderViewController.swift
//  CodeReader
//
//  Created by Won on 06/05/2017.
//  Copyright © 2017 Won. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation
import SafariServices
import AVFoundation


class RecognizerViewController: UIViewController {

	@IBOutlet weak var faceStatusLabel: UILabel!
	@IBOutlet weak var previewView: PreviewView!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var switchCameraButton: UIButton!
    @IBOutlet weak var predictionLabel: UILabel!
    
    var model = Inceptionv3()
    
    var session = AVCaptureSession()
    var videoConnection: AVCaptureConnection!
    var videoDeviceInput: AVCaptureDeviceInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        previewView.session = session
        addVideoInput()
        addVideoOutput()
        session.startRunning()
    }
    
    func addVideoOutput() {

        session.beginConfiguration()
        
        let videoDataOutput = AVCaptureVideoDataOutput()
        
        // TODO: Study
        // videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String : NSNumber(value: kCVPixelFormatType_32BGRA)]
        
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        let queue = DispatchQueue(label: "delegate_callbacks_q")
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
            videoConnection = videoDataOutput.connection(with: AVMediaType.video)
        }
        
        session.commitConfiguration()
    }
    
    func addVideoInput() {
        
        session.beginConfiguration()
        
        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: AVCaptureDevice.defaultVideoDevice!)
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
            }
            
            self.previewView.videoPreviewLayer.connection?.videoOrientation = .portrait
            
        } catch {
            print(error)
            session.commitConfiguration()
        }

        session.commitConfiguration()
    }
}

extension RecognizerViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ captureOutput: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        connection.videoOrientation = .portrait
        DispatchQueue.main.sync {
            if let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
                let ciImage = CIImage(cvImageBuffer: imageBuffer)
                let img = UIImage(ciImage: ciImage).resizeTo(CGSize(width: 299, height: 299))
                
                if let uiImage = img {
                    let pixelBuffer = uiImage.buffer()!
                    let output = try? model.prediction(image: pixelBuffer)
                    self.predictionLabel.text = output?.classLabel ?? "I don't know! 😞"
                }
            }
        }
    }
}
