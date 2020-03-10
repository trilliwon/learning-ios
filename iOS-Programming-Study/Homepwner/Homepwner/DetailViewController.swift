//
//  DetailViewController.swift
//  Homepwner
//
//  Created by USER on 07/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: BorderedUITextField!
    @IBOutlet weak var serialNumberField: BorderedUITextField!
    @IBOutlet weak var valueField: BorderedUITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var clearButton: UIBarButtonItem!

    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }

    var imageStore: ImageStore!

    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // clear first responder
        view.endEditing(true)

        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)

        let key = item.itemKey
        if let imageToDisplay = imageStore.image(forKey: key) {
            imageView.image = imageToDisplay
            clearButton.isEnabled = true
        } else {
            clearButton.isEnabled = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text

        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }

    @IBAction func takePickture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()

        // if the device has a camera, take a picture; otherwise
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            let view = imagePicker.view!
            let overlayView = UIView(frame: view.frame)
            overlayView.backgroundColor = UIColor.clear

            let vertical = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: view.frame.height))
            vertical.backgroundColor = UIColor.black.withAlphaComponent(0.7)

            let horizontal = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
            horizontal.backgroundColor = UIColor.black.withAlphaComponent(0.7)

            vertical.center.x = overlayView.center.x
            horizontal.center.y = overlayView.center.y

            overlayView.addSubview(vertical)
            overlayView.addSubview(horizontal)
            imagePicker.cameraOverlayView = overlayView
        } else {
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
        }

        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

    @IBAction func clearImage(_ sender: UIBarButtonItem) {
        imageStore.deleteImage(forKey: item.itemKey)
        imageView.image = nil
    }

    @IBAction func bacgroundTapped(_ sender: UITapGestureRecognizer) {

        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showChangeDate"?:
            let changeDateViewController = segue.destination as! ChangeDateViewController
            changeDateViewController.item = item
        default:
            return
        }
    }
}

extension DetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return
        }

        imageStore.setImage(image, forkey: item.itemKey)
        imageView.image = image

        dismiss(animated: true)
    }
}
