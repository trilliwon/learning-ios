import UIKit

@IBDesignable
class RoundedButton: UIButton {

  @IBInspectable var roundCorner: Bool = false {
    didSet {
			if roundCorner {
				self.layer.cornerRadius = self.frame.height/2
			}
    }
  }

  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
			if !roundCorner {
				layer.cornerRadius = cornerRadius
				layer.masksToBounds = true
			}
    }
  }

  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }

  @IBInspectable var borderColor: UIColor = UIColor.clear {
    didSet {
      layer.borderColor = borderColor.cgColor
    }
  }
}
