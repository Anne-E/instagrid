//
//  gridView.swift
//  instagrid
//
//  Created by Anne-Elisabeth on 28/04/2019.
//  Copyright © 2019 Anne-Elisabeth. All rights reserved.
//

import Foundation
import UIKit

protocol GridViewDelegate: class {
    func openImagePicker(_ sender: Any, grid: GridView)
}

class GridView: UIView {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    var imageToChange: UIImageView!
    
    weak var delegate: GridViewDelegate?
    
    // this function will determine the clicked button on the grid
    // Set imageToChange to know which image on the grid the user wants to change
    // and tell the delegate (ViewController) to open the imagePicker
    @IBAction func buttonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {
        
            switch button {
            case button1:
                imageToChange = image1
            case button2:
                imageToChange = image2
            case button3:
                imageToChange = image3
            case button4:
                imageToChange = image4
            default:
                return
            }
            
            if let delegate = delegate {
                delegate.openImagePicker(sender, grid: self)
            }
        }
    }
    
    public func setImage(_ image: UIImage) {
        imageToChange.image = image
    }
    
}
