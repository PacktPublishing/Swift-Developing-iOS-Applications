//
//  Photo.swift
//  LearningCamera
//
//  Created by Andrew J Wagner on 2/28/16.
//  Copyright © 2016 Learning Swift. All rights reserved.
//

import UIKit

struct Photo {
    enum Error: String, ErrorType {
        case CouldntGetImageData = "Couldn't get data from iamge"
        case CouldntWriteImageData = "Couldn't write image data"
    }

    let image: UIImage
    let label: String

    init(image: UIImage, label: String) {
        self.image = image
        self.label = label
    }

    init?(filePath: NSURL) {
        if let image = UIImage(
            contentsOfFile: filePath.relativePath!
            )
        {
            let label = filePath.URLByDeletingPathExtension?
                .lastPathComponent ?? ""
            self.init(image: image, label: label)
        }
        else {
           return nil
        }
    }

    func saveToDirectory(directory: NSURL) throws {
        let timeStamp = "\(NSDate().timeIntervalSince1970)"
        let fullDirectory = directory
            .URLByAppendingPathComponent(timeStamp)
        try NSFileManager.defaultManager().createDirectoryAtURL(
            fullDirectory,
            withIntermediateDirectories: true,
            attributes: nil
        )
        let fileName = "\(self.label).jpg"
        let filePath = fullDirectory
            .URLByAppendingPathComponent(fileName)
        if let data = UIImageJPEGRepresentation(self.image, 1) {
            if !data.writeToURL(filePath, atomically: true) {
                throw Error.CouldntWriteImageData
            }
        }
        else {
            throw Error.CouldntGetImageData
        }
    }
}