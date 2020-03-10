//
//  UIKit+Extensions.swift
//  SwitcherM
//
//  Created by Won on 15/05/2017.
//  Copyright © 2017 IO. All rights reserved.
//

import UIKit

enum PresentStyle {
  case push
  case fadeIn
}

enum DismissStyle {
  case pop
  case fadeOut
}

extension UIViewController {

  func present(destination: UIViewController, duration: TimeInterval = 0.2, style: PresentStyle) {
    switch style {
    case .push:
      presentAsPush(destination: destination, duration: duration)
    case .fadeIn:
      presentAsFadeIn(destination: destination, duration: duration)
    }
  }

  func dismiss(duration: TimeInterval = 0.2, dismissStyle: DismissStyle) {
    switch dismissStyle {
    case .pop:
      dismissAsPop(duration: duration)
    case .fadeOut:
      dismissAsFadeOut(duration: duration)
    }
  }

  // Present As Push
  func presentAsPush(destination: UIViewController, duration: TimeInterval = 0.2) {

    let sourceView: UIView = self.view
    let destinationView: UIView = destination.view

    guard let window: UIWindow = UIApplication.shared.keyWindow else {
      fatalError()
    }
    window.insertSubview(destinationView, aboveSubview: sourceView)

    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height

    destinationView.frame = CGRect(x: -screenWidth,
                                   y: 0.0,
                                   width: screenWidth,
                                   height: screenHeight)


    UIView.animate(withDuration: duration, animations: {
      sourceView.frame = sourceView.frame.offsetBy(dx: screenWidth, dy: 0.0)
      destinationView.frame = destinationView.frame.offsetBy(dx: screenWidth, dy: 0.0)
    }, completion: { _ in
      self.present(destination, animated: false)
    })
  }

  // Dismiss As Pop
  func dismissAsPop(duration: TimeInterval = 0.2) {

    guard let destination = self.presentingViewController else {
      self.dismiss(animated: false)
      return
    }

    let sourceView: UIView = self.view
    let destinationView: UIView

    if
      let destination = destination as? UINavigationController,
      let topView = destination.topViewController {
      destinationView = topView.view
    } else {
      destinationView = destination.view
    }

    guard let window: UIWindow = UIApplication.shared.keyWindow else {
      fatalError()
    }
    window.insertSubview(destinationView, aboveSubview: sourceView)

    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height

    destinationView.frame = CGRect(x: screenWidth,
                                   y: 0.0,
                                   width: screenWidth,
                                   height: screenHeight)

    UIView.animate(withDuration: duration, animations: {
      destinationView.frame = destinationView.frame.offsetBy(dx: -screenWidth, dy: 0.0)
      sourceView.frame = sourceView.frame.offsetBy(dx: -screenWidth, dy: 0.0)
    }, completion: { _ in
      self.dismiss(animated: false)
    })
  }

  // Present As FadeIn
  func presentAsFadeIn(destination: UIViewController, duration: TimeInterval = 0.2) {

    let sourceView: UIView = self.view
    let destinationView: UIView = destination.view

    sourceView.alpha = 1.0
    destinationView.alpha = 0.0

    guard let window: UIWindow = UIApplication.shared.keyWindow else {
      fatalError()
    }
    window.insertSubview(destinationView, aboveSubview: sourceView)

    UIView.animate(withDuration: duration, animations: {
      sourceView.alpha = 0.0
      destinationView.alpha = 1.0
    }, completion: { _ in
      self.present(destination, animated: false)
    })
  }

  // Dismiss As FadeOut
  func dismissAsFadeOut(duration: TimeInterval = 0.2) {

    guard let destination = self.presentingViewController else {
      self.dismiss(animated: false)
      return
    }

    let sourceView: UIView = self.view
    let destinationView: UIView

    if
      let destination = destination as? UINavigationController,
      let topView = destination.topViewController {
      destinationView = topView.view
    } else {
      destinationView = destination.view
    }

    guard let window: UIWindow = UIApplication.shared.keyWindow else {
      fatalError()
    }
    window.insertSubview(destinationView, aboveSubview: sourceView)

    sourceView.alpha = 1.0
    destinationView.alpha = 0.0

    UIView.animate(withDuration: duration, animations: {
      sourceView.alpha = 0.0
      destinationView.alpha = 1.0
    }, completion: { _ in
      self.dismiss(animated: false)
    })
  }

  static var instance: UIViewController {
    return UIStoryboard(name: self.className, bundle: nil).instantiateInitialViewController()!
  }

  func startRightBarIndicatorAnimating(style: UIActivityIndicatorViewStyle = .gray) {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: style)
    indicator.startAnimating()
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
  }

  func stopRightBarIndicatorAnimating() {
    if
      let rightBarButtonItem = self.navigationItem.rightBarButtonItem,
      let indicator = rightBarButtonItem.customView as? UIActivityIndicatorView {
      indicator.stopAnimating()
      self.navigationItem.rightBarButtonItem = nil
    }
  }

  func alert(title: String = "Notification",
             message: String,
             okTitle: String = "OK", okAction: (() -> Swift.Void)? = nil) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: okTitle, style: .cancel) { _ in
        guard let action = okAction else { return }
        action()
      }

      alert.addAction(okAction)
      alert.view.tintColor = UIColor.default

      self.present(alert, animated: true, completion: { alert.view.tintColor = UIColor.default })
    }
  }

  func alert(title: String = "Notification",
             message: String,
             cancelTitle: String = "Cancel",
             okTitle: String, okAction: @escaping () -> Void) {

    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: okTitle, style: UIAlertActionStyle.default) { _ in okAction() }
      let cancelAction = UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.cancel) { _ in  }

      alert.addAction(cancelAction)
      alert.addAction(okAction)
      alert.view.tintColor = UIColor.default
      self.present(alert, animated: true, completion: { alert.view.tintColor = UIColor.default })
    }
  }

}

extension UIButton {

  func makeUnderLinedButton() {
    if let title = self.title(for: .normal) {
      self.setAttributedTitle(title.underLined(), for: UIControlState())
    }
  }
}

extension UIFont {

  class func appleSDGothicNeoLight(size: CGFloat = 14) -> UIFont {
    return UIFont(name: "AppleSDGothicNeo-Light", size: size)!
  }
}

extension UITextField {

  func makeSubStringColored(subString: String, color: UIColor = UIColor.default) {
    self.attributedText = (self.text ?? "").colored(range: ((self.text ?? "") as NSString).range(of: subString), color: color)
  }

  func makeSubStringColored(range: (location: Int, length: Int), color: UIColor = UIColor.default) {
    self.attributedText = (self.text ?? "").colored(range: NSRange(location: range.location, length: range.length), color: color)
  }

  func setToolBarWithDoneButtonOnKeyboard(title: String? = nil) {
    let keyboardToolbar = UIToolbar()
    keyboardToolbar.barTintColor = UIColor(red: 204/255, green: 208/255, blue: 215/255, alpha: 1.0)
    keyboardToolbar.barStyle = .default
    keyboardToolbar.isTranslucent = true
    keyboardToolbar.sizeToFit()

    let doneButton = UIBarButtonItem(title: title ?? "OK", style: .done, target: nil, action: #selector(self.resignFirstResponder))

    doneButton.tintColor = UIColor.default
    let flexItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    keyboardToolbar.items = [flexItem, doneButton]
    self.inputAccessoryView = keyboardToolbar
  }
}

extension UILabel {

  func makeSubStringColored(subString: String, color: UIColor = UIColor.default) {
    self.attributedText = (self.text ?? "").colored(range: ((self.text ?? "") as NSString).range(of: subString), color: color)
  }
  
  func makeSubStringColored(range: (location: Int, length: Int), color: UIColor = UIColor.default) {
    self.attributedText = (self.text ?? "").colored(range: NSRange(location: range.location, length: range.length), color: color)
  }
}

extension UIColor {
  static var `default`: UIColor {
    return UIColor(red: 60/255, green: 160/255, blue: 220/225, alpha: 1.0)
  }
}
