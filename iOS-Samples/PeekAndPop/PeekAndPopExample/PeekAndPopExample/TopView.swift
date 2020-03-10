import UIKit

class TopView: PeekAndPopAction {

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var thumnailView: UIImageView! {
        didSet {
            thumnailView.layer.cornerRadius = 5.0
            thumnailView.clipsToBounds = true
        }
    }

    func loadNib() -> PeekAndPopAction? {
        return UINib(nibName: self.className, bundle: nil).instantiate(withOwner: self, options: nil).first as? PeekAndPopAction
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
