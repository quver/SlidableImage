//
//  SlidableImageFactory.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 04.03.2017.
//  Copyright © 2017 Quver. All rights reserved.
//

import UIKit

extension SlidableImage {
    
    struct Factory {
        
        static func makeSliderCircle(sliderImage: UIImage? = nil) -> UIView {
            let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            let circle = UIView(frame: frame)
            
            guard let sliderImage = sliderImage else {
                return ArrowsView(frame: frame)
            }
            
            circle.layer.cornerRadius = circle.bounds.width / 2
            
            let imageView = UIImageView(image: sliderImage)
            imageView.contentMode = .scaleAspectFill
            circle.addSubview(imageView)
            imageView.center = circle.center
            
            return circle
        }
        
        static func makeContainer(image: UIImage, frame: CGRect) -> UIImageView {
            let imageView = UIImageView(frame: frame)
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            
            return imageView
        }
        
        static func makeMaskRect(for maskLocation: CGFloat, bounds: CGRect, slideDirection: Direction) -> CGRect {
            switch slideDirection {
            case .left:
                return CGRect(x: maskLocation,
                              y: bounds.minY,
                              width: bounds.width,
                              height: bounds.height)
            case .right:
                return  CGRect(x: bounds.minX,
                               y: bounds.minY,
                               width: maskLocation,
                               height: bounds.height)
            case .top:
                return CGRect(x: bounds.minX,
                              y: maskLocation,
                              width: bounds.width,
                              height: bounds.height)
            case .bottom:
                return CGRect(x: bounds.minX,
                              y: bounds.minY,
                              width: bounds.width,
                              height: maskLocation)
            }
        }
    }
    
}
