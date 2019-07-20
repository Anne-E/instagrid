//
//  SelectersButtons.swift
//  instagrid
//
//  Created by Anne-Elisabeth on 28/04/2019.
//  Copyright © 2019 Anne-Elisabeth. All rights reserved.
//

import Foundation
import UIKit

protocol SelectersButtonsDelegate : class {
    func selectGrid(_ number: Int)
}

class SelectersButtons: UIView {
    
    @IBOutlet weak var selected1Image: UIImageView!
    @IBOutlet weak var selected2Image: UIImageView!
    @IBOutlet weak var selected3Image: UIImageView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    weak var delegate : SelectersButtonsDelegate?


    // this function is called when selectersButton appears on the app
    // so we can call our setup func
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // function to display the first button selected when the app just opens
    func setup() {
        hideAllButtons()
        selected1Image.isHidden = false
    }
    
    // function to hide all selected buttons
    func hideAllButtons() {
        selected1Image.isHidden = true
        selected2Image.isHidden = true
        selected3Image.isHidden = true
    }
    
    // Function that will manage the 3 buttons clicks
    // it will display the selected button
    // and tell the delegate (ViewController) which grid is selected
    
    @IBAction func layoutButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton,
            let delegate = delegate {
            hideAllButtons();
            switch button {
            case button1:
                selected1Image.isHidden = false
                delegate.selectGrid(1)
            case button2:
                selected2Image.isHidden = false
                delegate.selectGrid(2)
            case button3:
                selected3Image.isHidden = false
                delegate.selectGrid(3)
            default:
                break
        }
        }
    }
    
}
