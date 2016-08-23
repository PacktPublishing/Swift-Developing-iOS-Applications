//
//  ViewController.swift
//  LearningCamera
//
//  Created by Andrew J Wagner on 2/21/16.
//  Copyright © 2016 Learning Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    var photoStore: PhotoStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoStore = PhotoStore(
            cellForPhoto: self.createCellForPhoto
        )
        self.collectionView.dataSource = self.photoStore
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        do {
            try self.photoStore.loadPhotos()
            self.collectionView.reloadData()
        }
        catch let error {
            self.displayError(
                error,
                withTitle: "Error Loading Photos"
            )
        }
    }

    @IBAction func didTapTakePhotoButton(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        imagePicker.delegate = self
        self.presentViewController(
            imagePicker,
            animated: true,
            completion: nil
        )
    }

    func createCellForPhoto(
        photo: Photo,
        indexPath: NSIndexPath
        ) -> UICollectionViewCell
    {
        let cell = self.collectionView
            .dequeueReusableCellWithReuseIdentifier(
            "DefaultCell",
            forIndexPath: indexPath
            ) as! PhotoCollectionViewCell
        cell.imageView.image = photo.image
        cell.label.text = photo.label

        return cell
    }
}

extension ViewController: UINavigationControllerDelegate {}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingImage image: UIImage,
        editingInfo: [String : AnyObject]?
        )
    {
        self.dismissViewControllerAnimated(true) {
            // Ask User for Label

            let alertController = UIAlertController(
                title: "Photo Label",
                message: "How would you like to label your photo?",
                preferredStyle: .Alert
            )

            alertController.addTextFieldWithConfigurationHandler()
            {
                textField in
                let saveAction = self.createSaveActionWithTextField(
                    textField,
                    andImage: image
                )
                alertController.addAction(saveAction)
            }

            self.presentViewController(
                alertController,
                animated: true,
                completion: nil
            )
        }
    }
}

private extension ViewController {
    func displayErrorWithTitle(title: String?, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .Alert
        )
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .Default,
            handler: nil
        ))
        self.presentViewController(
            alert,
            animated: true,
            completion: nil
        )
    }

    func displayError(error: ErrorType, withTitle: String) {
        switch error {
        case let error as NSError:
            self.displayErrorWithTitle(
                title,
                message: error.localizedDescription
            )
        default:
            self.displayErrorWithTitle(
                title,
                message: "Unknown Error"
            )
        }
    }

    func createSaveActionWithTextField(
        textField: UITextField,
        andImage image: UIImage
        ) -> UIAlertAction
    {
        return UIAlertAction(
            title: "Save",
            style: .Default
            ) { action in
            do {
                let indexPath = try self.photoStore
                    .saveNewPhotoWithImage(
                        image,
                        labeled: textField.text ?? ""
                    )
                self.collectionView.insertItemsAtIndexPaths(
                    [indexPath]
                )
            }
            catch let error {
                self.displayError(
                    error,
                    withTitle: "Error Saving Photo"
                )
            }
        }
    }
}
