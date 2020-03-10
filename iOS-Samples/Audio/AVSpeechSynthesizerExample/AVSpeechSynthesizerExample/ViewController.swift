//
//  ViewController.swift
//  AVSpeechSynthesizerExample
//
//  Created by WON on 26/07/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var textView: UITextView!

    let avSpeech = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func speechButtonAction(_ sender: UIButton) {
        textView.resignFirstResponder()
        let speechUtterance = AVSpeechUtterance(string: textView.text)
        avSpeech.speak(speechUtterance)
    }

}

