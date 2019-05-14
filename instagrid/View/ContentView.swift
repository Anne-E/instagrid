//
//  ContentView.swift
//  instagrid
//
//  Created by Anne-Elisabeth on 12/05/2019.
//  Copyright © 2019 Anne-Elisabeth. All rights reserved.
//

import Foundation
import UIKit

class ContentView: UIView, GridViewDelegate, SelectersButtonsDelegate
{
    @IBOutlet weak var layout1View: GridView!
    @IBOutlet weak var layout2View: GridView!
    @IBOutlet weak var layout3View: GridView!
    
    public var selectedLayout: GridView?
    
    @IBOutlet weak var selectersButtons: SelectersButtons!
    
    var delegate: GridViewDelegate?
    
    func setup() {
        selectersButtons.delegate = self
        layout1View.delegate = self
        layout2View.delegate = self
        layout3View.delegate = self
        
        hideAllGrid()
        layout1View.isHidden = false
        selectedLayout = layout1View
    }
    
    // SelectersButtonsDelegate
    
    // function to unhide the selected grid
    
    func selectGrid(_ number: Int) {
        hideAllGrid()
        switch number {
        case 1:
            layout1View.isHidden = false
            selectedLayout = layout1View
        case 2:
            layout2View.isHidden = false
            selectedLayout = layout2View
        case 3:
            layout3View.isHidden = false
            selectedLayout = layout3View
        default:
            break
        }
    }
    
    // function to hide all the grids
    
    func hideAllGrid(){
        layout1View.isHidden = true
        layout2View.isHidden = true
        layout3View.isHidden = true
    }
    
    
    func openImagePicker(_ sender: Any, grid: GridView) {
        if let delegate = delegate {
            delegate.openImagePicker(sender, grid: grid)
        }
    }
}
