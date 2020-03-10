//
//  ImageStore.swift
//  Homepwner
//
//  Created by trilliwon on 09/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit


class ImageStore {

    let cache = NSCache<NSString, UIImage>()

    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }

    func setImage(_ image: UIImage, forkey key: String) {
        cache.setObject(image, forKey: key as NSString)

        let url = imageURL(forKey: key)
        // UIImagePNGRepresentation(image)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            try? data.write(to: url, options: [.atomic])
        }
    }

    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        let url = imageURL(forKey: key)
        if let imagefromDisk = UIImage(contentsOfFile: url.path) {
            cache.setObject(imagefromDisk, forKey: key as NSString)
            return imagefromDisk
        }
        return nil
    }

    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)

        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error removing the image from disk: \(error)")
        }
    }
}
