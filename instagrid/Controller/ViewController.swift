//
//  ViewController.swift
//  instagrid
//
//  Created by Anne-Elisabeth on 08/04/2019.
//  Copyright © 2019 Anne-Elisabeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var layout1Button: UIButton!
    @IBOutlet weak var layout2Button: UIButton!
    @IBOutlet weak var layout3Button: UIButton!
    @IBOutlet weak var selected1Image: UIImageView!
    @IBOutlet weak var selected2Image: UIImageView!
    @IBOutlet weak var selected3Image: UIImageView!
    @IBOutlet weak var layout1View: UIView!
    @IBOutlet weak var layout2View: UIView!
    @IBOutlet weak var layout3View: UIView!
    @IBOutlet weak var layout1Image1: UIImageView!
    @IBOutlet weak var layout1Image2: UIImageView!
    @IBOutlet weak var layout1Image3: UIImageView!
    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var imageToChange: UIImageView!
    
    // viewDidLoad function called when viewController contents are loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self;
        // Do any additional setup after loading the view.
        selected2Image.isHidden = true
        selected3Image.isHidden = true
        layout2View.isHidden = true
        layout3View.isHidden = true
    }

    @IBAction func layout1ButtonClicked(_ sender: Any) {
        selected1Image.isHidden = false
        selected2Image.isHidden = true
        selected3Image.isHidden = true
        layout1View.isHidden = false
        layout2View.isHidden = true
        layout3View.isHidden = true
        
    }
    
    @IBAction func layout2ButtonClicked(_ sender: Any) {
        selected2Image.isHidden = false
        selected1Image.isHidden = true
        selected3Image.isHidden = true
        layout2View.isHidden = false
        layout1View.isHidden = true
        layout3View.isHidden = true
    }
    
    @IBAction func layout3ButtonClicked(_ sender: Any) {
        selected3Image.isHidden = false
        selected1Image.isHidden = true
        selected2Image.isHidden = true
        layout3View.isHidden = false
        layout1View.isHidden = true
        layout2View.isHidden = true
    }
    
    
    @IBAction func layout1Button1Clicked(_ sender: Any) {
        imageToChange = layout1Image1;
        openAlert(sender)
    }
    
    @IBAction func layout1Button2Clicked(_ sender: Any) {
        imageToChange = layout1Image2;
        openAlert(sender)
    }
    
    @IBAction func layout1Button3Clicked(_ sender: Any) { imageToChange = layout1Image3;
        openAlert(sender)
    }
    
    func openAlert(_ sender: Any) {
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
            imageToChange.image = img;
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}

