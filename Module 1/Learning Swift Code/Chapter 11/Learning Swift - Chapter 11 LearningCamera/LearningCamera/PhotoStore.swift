//
//  PhotoStore.swift
//  LearningCamera
//
//  Created by Andrew J Wagner on 2/29/16.
//  Copyright © 2016 Learning Swift. All rights reserved.
//

import UIKit

class PhotoStore: NSObject {
    var photos = [Photo]()
    var cellForPhoto:
        (Photo, NSIndexPath) -> UICollectionViewCell

    init(
        cellForPhoto: (Photo,NSIndexPath) -> UICollectionViewCell
        )
    {
        self.cellForPhoto = cellForPhoto

        super.init()
    }

    func saveNewPhotoWithImage(
        image: UIImage,
        labeled label: String
        ) throws -> NSIndexPath
    {
        let photo = Photo(image: image, label: label)
        try photo.saveToDirectory(self.getSaveDirectory())
        self.photos.append(photo)
        return NSIndexPath(
            forItem: self.photos.count - 1,
            inSection: 0
        )
    }

    func loadPhotos() throws {
        self.photos.removeAll(keepCapacity: true)

        let fileManager = NSFileManager.defaultManager()
        let saveDirectory = try self.getSaveDirectory()
        let enumerator = fileManager.enumeratorAtPath(
            saveDirectory.relativePath!
        )
        while let file = enumerator?.nextObject() as? String {
            let fileType = enumerator!.fileAttributes![NSFileType]
                as! String
            if fileType == NSFileTypeRegular {
                let fullPath = saveDirectory
                    .URLByAppendingPathComponent(file)
                if let photo = Photo(filePath: fullPath) {
                    self.photos.append(photo)
                }
            }
        }
    }
}

extension PhotoStore: UICollectionViewDataSource {
    func collectionView(
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int
    {
        return self.photos.count
    }

    func collectionView(
        collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath
        ) -> UICollectionViewCell
    {
        let photo = self.photos[indexPath.item]
        return self.cellForPhoto(photo, indexPath)
    }
}

private extension PhotoStore {
    func getSaveDirectory() throws -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        return try fileManager.URLForDirectory(
            .DocumentDirectory,
            inDomain: .UserDomainMask,
            appropriateForURL: nil,
            create: true
        )
    }
}