import UIKit

class ViewController: UIViewController {

    fileprivate let peekedViewController = PeekAndPopController()

    @IBAction func presentAction(_ sender: Any) {
        present(peekedViewController, animated: true)
    }

    let forceTouch = ForceTouchGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()

        forceTouch.addTarget(self, action: #selector(touchAction(_:)))
        forceTouch.cancelsTouchesInView = false
        view.addGestureRecognizer(forceTouch)

        let download = PeekAndPopActionView(text: "Download", image: #imageLiteral(resourceName: "btnDownload"), handler: {
            print("Download Action")
        })

        let playNext = PeekAndPopActionView(text: "Play Next", image: #imageLiteral(resourceName: "btnDownload"), handler: {
            print("Play Next Action")
        })

        let playLast = PeekAndPopActionView(text: "Play Later", image: #imageLiteral(resourceName: "btnDownload"), handler: {
            print("Play Last Action")
        })

        let share = PeekAndPopActionView(text: "Share", image: #imageLiteral(resourceName: "btnDownload"), handler: {
            print("Share Action")
        })

        peekedViewController.addAction(download)
        peekedViewController.addAction(playNext)
        peekedViewController.addAction(playLast)
        peekedViewController.addAction(share)
        peekedViewController.topView = TopView().loadNib()

        peekedViewController.topView?.handler = {
            print("Play Play Play")
        }
    }

    @objc func touchAction(_ gesture: ForceTouchGestureRecognizer) {
        print(#function, gesture.touch?.location(in: view) ?? "")
        present(peekedViewController, animated: true)
    }
}


