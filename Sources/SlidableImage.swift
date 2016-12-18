//
//  SlidableView.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 09.04.2016.
//  Copyright © 2016 Quver. All rights reserved.
//

import UIKit

/// Super easy Slider for before&after images
open class SlidableImage: UIView {

  /// First image container view. You can override it with your custom view.
  open var firstView: UIView

  /// Second image container view. You can override it with your custom view.
  open var secondView: UIView

  /// Circle view with icon for sliding images. You can override it with your custom view.
  open var sliderCircle: UIView

  /// Generic initializer with views
  ///
  /// - Parameters:
  ///   - frame: Frame size
  ///   - firstView: First view - should have size equal to frame and second view
  ///   - secondView: Second view - should have size equal to frame and second view
  public init(frame: CGRect, firstView: UIView, secondView: UIView) {
    self.firstView = firstView
    self.secondView = secondView
    sliderCircle = SlidableImage.setupSliderCircle()
    super.init(frame: frame)

    initializeViews()
    initializeGestureRecognizer()
  }

  /// Short way to initialize SlidableView. You need target size and images.
  ///
  /// - Parameters:
  ///   - frame: Frame size
  ///   - firstImage: First image for sliding
  ///   - secondImage: Second image for sliding
  convenience public init(frame: CGRect, firstImage: UIImage, secondImage: UIImage) {
    let firstView = SlidableImage.setup(image: firstImage, frame: frame)
    let secondView = SlidableImage.setup(image: secondImage, frame: frame)

    self.init(frame: frame, firstView: firstView, secondView: secondView)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Typicaly this method is used by gesture recognizer, but you can use it for first state or animations
  ///
  /// - Parameter maskLocation: Position of slider
  open func updateMask(location maskLocation: CGFloat) {
    let maskRectPath = UIBezierPath(rect: CGRect(x: bounds.minX,
                                                 y: bounds.minY,
                                                 width: maskLocation,
                                                 height: bounds.height))
    let mask = CAShapeLayer()
    mask.path = maskRectPath.cgPath
    secondView.layer.mask = mask

    sliderCircle.center.x = maskLocation
  }

  /// Private wrapper for setup view
  fileprivate func initializeViews() {
    clipsToBounds = true
    sliderCircle.center = center
    updateMask(location: center.x)

    addSubview(firstView)
    addSubview(secondView)
    addSubview(sliderCircle)
  }

  /// Private wrapper for adding gesture recognizer
  private func initializeGestureRecognizer() {
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureHandler))
    sliderCircle.addGestureRecognizer(panGestureRecognizer)
  }

  @objc private func gestureHandler(_ panGestureRecognizer: UIPanGestureRecognizer) {
    let location = panGestureRecognizer.location(in: firstView)

    guard (bounds.minX...bounds.maxX ~= location.x) else {
      return
    }

    updateMask(location: location.x)
  }

  /// Private wrapper for setup circle slider view
  ///
  /// - Returns: Slider circle
  private class func setupSliderCircle() -> UIView {
    let frame = CGRect(x: 0, y: 0, width: 50, height: 50)

    return ArrowsView(frame: frame)
  }

  /// Private wrapper for setup image view
  ///
  /// - Parameters:
  ///   - image: Content image
  ///   - frame: Target frame
  /// - Returns: Prepared UIImageView
  private class func setup(image: UIImage, frame: CGRect) -> UIImageView {
    let imageView = UIImageView(frame: frame)
    imageView.image = image
    imageView.contentMode = .scaleAspectFill

    return imageView
  }

}
