//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by WON on 11/08/2018.
//  Copyright © 2018 trilliwon. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    var photo: Photo! {
        didSet {
            navigationItem.title = photo?.title
            print(photo)
        }
    }

    var store: PhotoStore!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.accessibilityLabel = photo.title

        store.fetchImage(for: photo) { result in
            switch result {
            case let .success(image):
                self.imageView.image = image
                self.photo.viewCount += 1
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTags"?:
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController

            tagController.store = store
            tagController.photo = photo
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
