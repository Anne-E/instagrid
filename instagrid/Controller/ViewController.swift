//
//  ViewController.swift
//  instagrid
//
//  Created by Anne-Elisabeth on 08/04/2019.
//  Copyright © 2019 Anne-Elisabeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GridViewDelegate, SelectersButtonsDelegate {

    @IBOutlet weak var layout1View: GridView!
    @IBOutlet weak var layout2View: GridView!
    @IBOutlet weak var layout3View: GridView!
    
    @IBOutlet weak var swipeLabel: UILabel!
    
    @IBOutlet weak var selectersButtons: SelectersButtons!
    var gridSelected: GridView!

    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    
    // viewDidLoad function called when viewController contents are loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // This function sets up all the delegate of the layoutviews
    // and displays only the first grid
    func setup() {
        imagePicker.delegate = self
        selectersButtons.delegate = self
        layout1View.delegate = self
        layout2View.delegate = self
        layout3View.delegate = self
        
        hideAllGrid()
        layout1View.isHidden = false
    }
    
    // function to hide all the grids
    
    func hideAllGrid(){
        layout1View.isHidden = true
        layout2View.isHidden = true
        layout3View.isHidden = true
    }
    
    // SelectersButtonsDelegate
    
    // function to unhide the selected grid
    
    func selectGrid(_ number: Int) {
        hideAllGrid()
        switch number {
        case 1:
            layout1View.isHidden = false
        case 2:
            layout2View.isHidden = false
        case 3:
            layout3View.isHidden = false
        default:
            break
        }
    }
    
    // GridViewDelegate
    
    // function to open the image picker
    
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
        
        
        alert.popoverPresentationController?.sourceView = sender as? UIView
        alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
        alert.popoverPresentationController?.permittedArrowDirections = .up
        self.show(alert, sender: self)
    }
    
    // function to open the camera or the gallery
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // ImagePickerDelegate
    // We specify the behavior of the imagePicker by being its delegate
    // So we can control what happens when the user finishes to select a media in the imagePicker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img: UIImage = info[.originalImage] as? UIImage {
            gridSelected.setImage(img)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // to tell the system our viewController will respond to motion gestures
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.view.backgroundColor = UIColor.random()
        }
    }
}

// Extension to add a function to an existing class
// Generates a random float value : goal is to change the colour randomnly when shaking the IPhone

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
