//
//  SlidableView.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 09.04.2016.
//  Copyright © 2016 Quver. All rights reserved.
//

import UIKit

public enum SlideDirection: Int {
  case left
  case right
  case top
  case bottom
}

public struct SlidableImageBorder {
  var borderWidth: CGFloat
  var borderColor: CGColor
    
  public init(borderWidth width: CGFloat, borderColor color: CGColor) {
    self.borderWidth = width
    self.borderColor = color
  }
}

/// Super easy Slider for before&after images
open class SlidableImage: UIView {

  /// First image container view. You can override it with your custom view.
  open var firstView: UIView

  /// Second image container view. You can override it with your custom view.
  open var secondView: UIView

  /// Circle view with icon for sliding images. You can override it with your custom view.
  open var sliderCircle: UIView

  /// Enum that describes which direction the slider will slide from.
  open var slideDirection: SlideDirection
    
  /// Generic initializer with views
  ///
  /// - Parameters:
  ///   - frame: Frame size
  ///   - firstView: First view - should have size equal to frame and second view
  ///   - secondView: Second view - should have size equal to frame and second view
  public init(frame: CGRect, firstView: UIView, secondView: UIView, sliderImage: UIImage? = nil, slideDirection: SlideDirection? = nil) {
    self.firstView = firstView
    self.secondView = secondView
    self.sliderCircle = SlidableImage.setupSliderCircle(sliderImage: sliderImage)
    self.slideDirection = slideDirection ?? .right
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
  convenience public init(frame: CGRect, firstImage: UIImage, secondImage: UIImage, sliderImage: UIImage? = nil, slideDirection: SlideDirection? = nil) {
    let firstView = SlidableImage.setup(image: firstImage, frame: frame)
    let secondView = SlidableImage.setup(image: secondImage, frame: frame)
    
    self.init(frame: frame, firstView: firstView, secondView: secondView, sliderImage: sliderImage, slideDirection: slideDirection)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Typicaly this method is used by gesture recognizer, but you can use it for first state or animations
  ///
  /// - Parameter maskLocation: Position of slider
  open func updateMask(location maskLocation: CGFloat) {
    var maskRectPath: UIBezierPath
    let mask = CAShapeLayer()
    switch slideDirection {
      case .left:
        maskRectPath = UIBezierPath(rect: CGRect(x: maskLocation,
                                                 y: bounds.minY,
                                                 width: bounds.width,
                                                 height: bounds.height))
      case .right:
        maskRectPath = UIBezierPath(rect: CGRect(x: bounds.minX,
                                                 y: bounds.minY,
                                                 width: maskLocation,
                                                 height: bounds.height))
      case .top:
        maskRectPath = UIBezierPath(rect: CGRect(x: bounds.minX,
                                                 y: maskLocation,
                                                 width: bounds.width,
                                                 height: bounds.height))
      case .bottom:
        maskRectPath = UIBezierPath(rect: CGRect(x: bounds.minX,
                                                 y: bounds.minY,
                                                 width: bounds.width,
                                                 height: maskLocation))
    }
    mask.path = maskRectPath.cgPath
    secondView.layer.mask = mask
    if slideDirection == .left || slideDirection == .right {
      sliderCircle.center.x = maskLocation
    } else {
      sliderCircle.center.y = maskLocation
    }
  }

  /// Private wrapper for setup view
  fileprivate func initializeViews() {
    clipsToBounds = true
    sliderCircle.center = center
    if slideDirection == .left || slideDirection == .right {
      updateMask(location: center.x)
    } else {
      updateMask(location: center.y)
    }
    
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

    if slideDirection == .left || slideDirection == .right {
      guard (bounds.minX...bounds.maxX ~= location.x) else { return }
      updateMask(location: location.x)
    } else {
      guard (bounds.minY...bounds.maxY ~= location.y) else { return }
      updateMask(location: location.y)
    }
  }

  /// Private wrapper for setup circle slider view
  ///
  /// - Returns: Slider circle
  private class func setupSliderCircle(sliderImage: UIImage? = nil) -> UIView {
    // Workaround - without this view, gesture recognizer doesn't work
    let circle = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    circle.layer.cornerRadius = circle.bounds.width / 2
    
    let imageView = UIImageView(image: sliderImage)
    imageView.contentMode = .scaleAspectFill
    circle.addSubview(imageView)
    imageView.center = circle.center
        
    return circle
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
