//
//  Circle.swift
//  Breathe-Animation
//
//  Created by Besher on 2020-03-11.
//  Copyright © 2020 Besher. All rights reserved.
//

import UIKit

class Circle: CAShapeLayer {
    
    private let centerOffset: CGFloat = 0.855
    private let minimumScale: CGFloat = 0.25
    private var index: Int = 0
    private var side: CGFloat = 0
    private var color: CGColor = UIColor.clear.cgColor
    
    
    init(radius: CGFloat, index: Int, color: CGColor) {
        self.side = 2.0 * radius
        self.index = index
        self.color = color
        super.init()
        
        initialSetup()
    }
    
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Cannot initialize from storyboard")
    }
    
    
    private func initialSetup() {
        let rect = CGRect(x: 0, y: 0,
                          width: side,
                          height: side)
        
        self.transform = getTransform(for: centerOffset)
        self.fillColor = color
        self.path = UIBezierPath(roundedRect: rect, cornerRadius: side / 2).cgPath
        self.position = getPosition(for: centerOffset)
        self.compositingFilter = "linearDodgeBlendMode"
    }
    
    
    private func getTransform(for centerOffset: CGFloat) -> CATransform3D {
        let offset: CGFloat = .pi / 4
        let rotation: CGFloat = ((.pi * 2) / 6) * CGFloat(index)
        
        let rotationPoint = CGPoint(x: side, y: side)
        let center = CGPoint(x: side * centerOffset, y: side * centerOffset)
        let scale = getScale(for: centerOffset)
        
        var transform: CATransform3D = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, rotationPoint.x-center.x, rotationPoint.y-center.y, 0.0)
        transform = CATransform3DScale(transform, scale, scale, scale)
        transform = CATransform3DRotate(transform, rotation - offset, 0.0, 0.0, 1.0)
        transform = CATransform3DTranslate(transform, center.x-rotationPoint.x, center.y-rotationPoint.y, 0.0)
        
        return transform
    }
    
    
    private func getScale(for offset: CGFloat) -> CGFloat {
        let range = self.centerOffset - 0.5
        let factor = (1 - minimumScale) / range
        let diff = offset - 0.5
        let scale = minimumScale + (diff * factor)
        return scale
    }
    
    
    private func getPosition(for centerOffset: CGFloat) -> CGPoint {
        CGPoint(x: side * centerOffset, y: side * centerOffset)
    }
    
    
    private func createRotateAnimation(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = duration
        animation.fromValue = transform
        animation.toValue = getTransform(for: 0.5)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        add(animation, forKey: "rotate")
    }
    
    
    private func createPositionAnimation(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = duration
        animation.fromValue = position
        animation.toValue = getPosition(for: 0.5)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        add(animation, forKey: "position")
    }
    
    
    func animateWith(duration: TimeInterval) {
        createRotateAnimation(duration: duration)
        createPositionAnimation(duration: duration)
    }
    
    
    func updateColor(to color: CGColor) {
        setValue(color, forKey: "fillColor")
    }
}
