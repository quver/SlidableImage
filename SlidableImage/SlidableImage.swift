//
//  SlidableView.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 09.04.2016.
//  Copyright © 2016 Quver.xyz. All rights reserved.
//

import UIKit

class SlidableImage: UIView {

    /**
     First image container view. You can override it with your custom view.
     */
    var firstView: UIView

    /**
     Second image container view. You can override it with your custom view.
     */
    var secondView: UIView

    /**
     Circle view with icon for sliding images. You can override it with your custom view.
    */
    var sliderCircle: UIView

    /**
     Generic initializer with views

     - parameter frame:      Frame size
     - parameter firstView:  First view - should have size equal to frame and second view
     - parameter secondView: Second view - should have size equal to frame and second view

     - returns: instance
     */
    init(frame: CGRect, firstView: UIView, secondView: UIView) {
        self.firstView = firstView
        self.secondView = secondView
        sliderCircle = SlidableImage.prepareSliderCircle()
        super.init(frame: frame)

        initializeView()
        initializeGestureRecognizer()
    }

    /**
     Short way to initialize SlidableView. You need target size and images.

     - parameter frame:       Frame size
     - parameter firstImage:  Sirst image for sliding
     - parameter secondImage: Second image for sliding

     - returns: instance
     */
    convenience init(frame: CGRect, firstImage: UIImage, secondImage: UIImage) {
        let firstView = UIImageView(frame: frame)
        firstView.image = UIImage(named: "draw")
        firstView.contentMode = .ScaleAspectFill
        
        let secondView = UIImageView(frame: frame)
        secondView.image = UIImage(named: "photo")
        secondView.contentMode = .ScaleAspectFill

        self.init(frame: frame, firstView: firstView, secondView: secondView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     Typicaly this method is used by gesture recognizer, but you can use it for first state or animations

     - parameter maskLocation: x-axis location in frame, where image should be slided
     */
    func updateMask(maskLocation: CGFloat) {
        let maskRectPath = UIBezierPath(rect: CGRect(x: self.bounds.minX, y: bounds.minY, width: maskLocation, height: bounds.height))
        let mask = CAShapeLayer()
        mask.path = maskRectPath.CGPath
        secondView.layer.mask = mask

        sliderCircle.center.x = maskLocation
    }

    private func initializeView() {
        clipsToBounds = true
        sliderCircle.center = center
        updateMask(center.x)

        addSubview(firstView)
        addSubview(secondView)
        addSubview(sliderCircle)
    }

    private func initializeGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureHandler))
        sliderCircle.addGestureRecognizer(panGestureRecognizer)
    }

    @objc private func gestureHandler(panGestureRecognizer: UIPanGestureRecognizer) {
        let location = panGestureRecognizer.locationInView(firstView)

        if !(self.bounds.minX ... self.bounds.maxX ~= location.x) {
            return
        }

        updateMask(location.x)

    }

    private class func prepareSliderCircle() -> UIView {
        // Workaround - without this view, gesture recognizer doesn't work
        let circle = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        circle.layer.cornerRadius = circle.bounds.width / 2

        let imageView = UIImageView(image: UIImage(named: "slider"))
        circle.addSubview(imageView)

        return circle
    }
}
