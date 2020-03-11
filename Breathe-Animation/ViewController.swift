//
//  ViewController.swift
//  Breathe-Animation
//
//  Created by Besher on 2020-03-11.
//  Copyright © 2020 Besher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var breatheView: BreatheView!
    @IBOutlet var colorPickerContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addColorPicker(to: colorPickerContainer)
    }
    
    
    @IBAction func resetColorTapped(_ sender: UIButton) {
        breatheView?.resetColor()
    }
    
    
    func addColorPicker(to container: UIView) {
        
        let breatheView = self.breatheView
        let colorPickerView = ColorPickerView(frame: container.bounds)
        
        container.addSubview(colorPickerView)
        
        colorPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorPickerView.widthAnchor.constraint(equalTo: container.widthAnchor),
            colorPickerView.heightAnchor.constraint(equalTo: container.heightAnchor),
            colorPickerView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            colorPickerView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        colorPickerView.didChangeColor = { color in
            if let color = color {
                breatheView?.updateCirclesColor(to: color.withAlphaComponent(0.5).cgColor)
            }
        }
    }

}

