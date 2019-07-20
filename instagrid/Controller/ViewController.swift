//
//  ViewController.swift
//  instagrid
//
//  Created by Anne-Elisabeth on 08/04/2019.
//  Copyright © 2019 Anne-Elisabeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GridViewDelegate {

    @IBOutlet weak var contentView: ContentView!
    @IBOutlet weak var swipeLabel: UILabel!

    var gridSelected: GridView!
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var swipeUpRecognizer: UISwipeGestureRecognizer?
    
    // viewDidLoad function called when viewController contents are loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // This function sets up all the delegates of the layoutviews
    // and displays only the first grid
    func setup() {
        imagePicker.delegate = self
        contentView.setup()
        contentView.delegate = self
        
        // Init the gesture Recognizer and set the receiver to self.swipeUp()
        
        swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp(swipeRecognizer:)))
        
        // If init works set the direction of the swipe and
        // Add the gesture recognizer on the view we want to be swipable on
        
        if let swipeUpRecognizer = swipeUpRecognizer {
            swipeUpRecognizer.direction = .up
            self.view.addGestureRecognizer(swipeUpRecognizer)
        }
    }
    
    //swipeUp gives choices to the user : which image to choose and share
    @objc func swipeUp(swipeRecognizer: UISwipeGestureRecognizer) {
        
        if let imageToShare: UIImage = contentView.selectedLayout?.asImage() {
            // set up activity of viewController
            let toShare = [ imageToShare ]
            let activityViewController = UIActivityViewController(activityItems: toShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
        
    }
    
     //GridViewDelegate
    // method called because class ViewController conforms to GridView Delegate.
    
    func openImagePicker(_ sender: Any, grid: GridView) {
        self.gridSelected = grid
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.show(alert, sender: self)
    }
    
    // method to open the camera or the gallery
    
    func openCamera(){
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        } else{
            let alert = UIAlertController(title: "Warning", message: "You don't have a camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //UIImagePickerControllerDelegate
    // method called because class ViewController conforms to UIImagePickerControllerDelegate
    // decide what happens when the user finishes to select a media in the imagePicker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
                                info: [UIImagePickerController.InfoKey : Any]) {
        if let img: UIImage = info[.originalImage] as? UIImage {
            gridSelected.setImage(img)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // method that tells the system the viewController will respond to motion gestures
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    // change of background color when shaking the phone
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion ==  .motionShake {
            self.view.backgroundColor = UIColor.random()
        }
    }
}




