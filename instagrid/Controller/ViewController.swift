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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func layout1ButtonClicked(_ sender: Any) {
        selected1Image.isHidden = !selected1Image.isHidden
    }
    
}

