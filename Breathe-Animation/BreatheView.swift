//
//  BreatheView.swift
//  Breathe-Animation
//
//  Created by Besher on 2020-03-11.
//  Copyright © 2020 Besher. All rights reserved.
//

import UIKit

class BreatheView: UIView {
    
    private var containerLayer: CALayer?
    private var containerSize: CGFloat = 120.0
    private let animationDuration: TimeInterval = 4.0
    private let defaultColor: CGColor = {
        let blue = UIColor(red: 76/255, green: 175/255, blue: 247/255, alpha: 1)
        return blue.withAlphaComponent(0.7).cgColor
    }()
    
    private var circles: [Circle] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if containerLayer == nil {
            let container = setupContainer(size: containerSize)
            layer.addSublayer(container)
            containerLayer = container
            rotateContainer()
        }
    }
    
    private func setupContainer(size: CGFloat) -> CALayer {
        let container = CAShapeLayer()
        let rect = CGRect(x: 0, y: 0,
                            width: 2.0 * size,
                            height: 2.0 * size)
        
        container.path = UIBezierPath(rect: rect).cgPath
        container.position = CGPoint(x: frame.midX - size, y: frame.midY - size)
        
        let totalCircles = 6
            
        for i in 1...totalCircles {
            
            let circle = Circle(radius: containerSize / 2,
                                index: i,
                                color: defaultColor)
            circle.animateWith(duration: animationDuration)
            circles.append(circle)
            container.addSublayer(circle)
        }
        
        return container
    }
    
    
    private func rotateContainer() {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = animationDuration
        animation.fromValue = layer.transform
        animation.toValue = CATransform3DMakeRotation(.pi, 0, 0, 1)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "rotate")
    }
    
    
    func resetColor() {
        updateCirclesColor(to: defaultColor)
    }
    
    
    func updateCirclesColor(to color: CGColor) {
        for circle in circles {
            circle.updateColor(to: color)
        }
    }
}
