//
//  SlidableView.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 09.04.2016.
//  Copyright © 2016 Quver. All rights reserved.
//

import UIKit

/// Super easy Slider for before&after images
public class SlidableImage: UIView {

  /**
   First image container view. You can override it with your custom view.
   */
  public var firstView: UIView

  /**
   Second image container view. You can override it with your custom view.
   */
  public var secondView: UIView

  /**
   Circle view with icon for sliding images. You can override it with your custom view.
   */
  public var sliderCircle: UIView

  /**
   Generic initializer with views

   - parameter frame:      Frame size
   - parameter firstView:  First view - should have size equal to frame and second view
   - parameter secondView: Second view - should have size equal to frame and second view

   - returns: instance
   */
  public init(frame: CGRect, firstView: UIView, secondView: UIView) {
    self.firstView = firstView
    self.secondView = secondView
    sliderCircle = SlidableImage.setupSliderCircle()
    super.init(frame: frame)

    initializeView()
    initializeGestureRecognizer()
  }

  /**
   Short way to initialize SlidableView. You need target size and images.

   - parameter frame:       Frame size
   - parameter firstImage:  First image for sliding
   - parameter secondImage: Second image for sliding

   - returns: instance
   */
  convenience public init(frame: CGRect, firstImage: UIImage, secondImage: UIImage) {
    let firstView = SlidableImage.setup(image: firstImage, frame: frame)
    let secondView = SlidableImage.setup(image: secondImage, frame: frame)

    self.init(frame: frame, firstView: firstView, secondView: secondView)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /**
   Typicaly this method is used by gesture recognizer, but you can use it for first state or animations

   - parameter maskLocation: x-axis location in frame, where image should be slided
   */
  public func updateMask(_ maskLocation: CGFloat) {
    let maskRectPath = UIBezierPath(rect: CGRect(x: self.bounds.minX,
                                                 y: bounds.minY,
                                                 width: maskLocation,
                                                 height: bounds.height))
    let mask = CAShapeLayer()
    mask.path = maskRectPath.cgPath
    secondView.layer.mask = mask

    sliderCircle.center.x = maskLocation
  }

  /**
   Private wrapper for setup view
   */
  private func initializeView() {
    clipsToBounds = true
    sliderCircle.center = center
    updateMask(center.x)

    addSubview(firstView)
    addSubview(secondView)
    addSubview(sliderCircle)
  }

  /**
   Private wrapper for adding gesture recognizer
   */
  private func initializeGestureRecognizer() {
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureHandler))
    sliderCircle.addGestureRecognizer(panGestureRecognizer)
  }

  @objc private func gestureHandler(_ panGestureRecognizer: UIPanGestureRecognizer) {
    let location = panGestureRecognizer.location(in: firstView)

    if !(self.bounds.minX ... self.bounds.maxX ~= location.x) {
      return
    }

    updateMask(location.x)

  }

  /**
   Private wrapper for setup circle slider view
   */
  private class func setupSliderCircle() -> UIView {
    // Workaround - without this view, gesture recognizer doesn't work
    let circle = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    circle.layer.cornerRadius = circle.bounds.width / 2

    let imageView = UIImageView(image: UIImage(named: "slider"))
    circle.addSubview(imageView)

    return circle
  }

  /**
   Private wrapper for setup image view
   */
  private class func setup(image: UIImage, frame: CGRect) -> UIImageView {
    let imageView = UIImageView(frame: frame)
    imageView.image = image
    imageView.contentMode = .scaleAspectFill

    return imageView
  }

}
