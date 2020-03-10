import UIKit

class PeekAndPopAction: UIView {

    var handler: (() -> Void)?
    let selection = UISelectionFeedbackGenerator()

    var isHighlighted: Bool = false {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray.withAlphaComponent(0.5) : .lightText
            if oldValue != isHighlighted && isHighlighted {
                selection.selectionChanged()
            }
        }
    }
}

class PeekAndPopActionView: PeekAndPopAction {

    var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.contentMode = .left
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        return label
    }()

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 50, height: 50)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var topLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        return line
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }

    convenience init(text: String?, image: UIImage, handler: (() -> Void)? = nil) {
        self.init(frame: .zero)
        self.textLabel.text = text
        self.imageView.image = image
        self.handler = handler
        configureSubviews()
    }

    private func configureSubviews() {
        addSubview(topLine)
        addSubview(textLabel)
        addSubview(imageView)
        textLabel.sizeToFit()

        backgroundColor = UIColor.lightText

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 55).isActive = true

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        topLine.translatesAutoresizingMaskIntoConstraints = false

        topLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        topLine.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topLine.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topLine.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        textLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor).isActive = true

        layoutIfNeeded()
    }
}
