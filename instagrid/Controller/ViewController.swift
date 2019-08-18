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
    var swipeRecognizer: UISwipeGestureRecognizer?
    
	@IBOutlet weak var layoutView: UIView!
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
        setupSwipe()
    }
    // viewWillTransition function called when viewController orientation changes
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupSwipe()
    }
    
    // Function setupSwipe to create and add the swipe gesture recognizer (delete previous one if already exist)
    func setupSwipe() {
        
        // If swipe gesture recognizer already exists remove it
        
        if let swipeRecognizer = swipeRecognizer {
            self.view.removeGestureRecognizer(swipeRecognizer)
        }
        
        // Init the gesture Recognizer and set the receiver to self.swipeUp()
        
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swiped(swipeRecognizer:)))
        
        // If init works set the direction of the swipe depending on the orientation of the device and
        // Add the gesture recognizer on the view we want to be swipable on
        
        if let swipeRecognizer = swipeRecognizer {
            if UIDevice.current.orientation.isLandscape {
                swipeRecognizer.direction = .left
                swipeLabel.text = "Swipe left to share"
            } else {
                swipeRecognizer.direction = .up
                swipeLabel.text = "Swipe up to share"
            }
            self.view.addGestureRecognizer(swipeRecognizer)
        }
    }
    
    
    //swiped gives choices to the user : which services to use to share selected images
    @objc func swiped(swipeRecognizer: UISwipeGestureRecognizer) {
        
        if let imageToShare: UIImage = contentView.selectedLayout?.asImage() {
            
            // set up activity of viewController + display standard services offered from app
            let toShare = [ imageToShare ]
            let activityViewController = UIActivityViewController(activityItems: toShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            // We set the completion of the activityViewController to have our code called when the share is finished

            activityViewController.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
				
                UIView.animate(withDuration: 0.50, animations: {
					self.layoutView.transform = .identity
                })
            }

            UIView.animate(withDuration: 0.50, animations: {
				if UIDevice.current.orientation.isLandscape {
					self.layoutView.transform = CGAffineTransform(translationX: -2000, y: 0)
				} else {
					self.layoutView.transform = CGAffineTransform(translationX: 0, y: -2000)
				}
				
            }) { completed in
                if completed {
                    //presents the viewController
                    self.present(activityViewController, animated: true, completion: nil)
                }
            }
            
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
    
    // methods to open the camera or the gallery
    
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
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    //UIImagePickerControllerDelegate
    // method called because class ViewController conforms to UIImagePickerControllerDelegate
    // decides what happens when the user finishes to select a media in the imagePicker
    
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




