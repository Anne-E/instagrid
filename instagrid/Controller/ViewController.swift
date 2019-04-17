//
//  ViewController.swift
//  instagrid
//
//  Created by Anne-Elisabeth on 08/04/2019.
//  Copyright © 2019 Anne-Elisabeth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var layout1Button: UIButton!
    @IBOutlet weak var layout2Button: UIButton!
    @IBOutlet weak var layout3Button: UIButton!
    @IBOutlet weak var selected1Image: UIImageView!
    @IBOutlet weak var selected2Image: UIImageView!
    @IBOutlet weak var selected3Image: UIImageView!
    @IBOutlet weak var layout1View: UIView!
    @IBOutlet weak var layout2View: UIView!
    @IBOutlet weak var layout3View: UIView!
    
    // viewDidLoad function called when viewController contents are loaded
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

