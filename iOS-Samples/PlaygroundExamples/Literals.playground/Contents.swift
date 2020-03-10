import UIKit
//: # Literals in a Playground
//:
//: ### Image Literals
//: Here we're creating a template image from a `.png` file in our resources. The default type for image literals is **NSImage** on OS X and **UIImage** on iOS and tvOS.
let swiftTemplate = #imageLiteral(resourceName: "swift.png").withRenderingMode(.alwaysTemplate)

//: ### Color Literals
//: Now we're setting the tint color of a **UIImageView** with our template image, and the colors for a **CAGradientLayer** to serve as our background. The default type for color literals is **NSColor** on OS X and **UIColor** on iOS and tvOS. Try changing the colors by double-clicking on a color literal.
let imageView = UIImageView(image: swiftTemplate)
imageView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let gradientLayer = CAGradientLayer()
gradientLayer.colors = [#colorLiteral(red: 0.9725490196, green: 0.5411764706, blue: 0.2117647059, alpha: 1).cgColor, #colorLiteral(red: 0.9921568627, green: 0.1254901961, blue: 0.1254901961, alpha: 1).cgColor]

let backgroundView = UIView(frame: imageView.bounds)
gradientLayer.frame = backgroundView.bounds

backgroundView.layer.addSublayer(gradientLayer)
backgroundView.addSubview(imageView)


if let asciiSwift = try? String(contentsOf: #fileLiteral(resourceName: "swiftAsASCII.txt")) {
    if let font = UIFont(name: "Courier", size: 10.0) {
        let attrString = NSAttributedString(string: asciiSwift, attributes: [NSAttributedString.Key.font : font])
        print(attrString)
    }
}
