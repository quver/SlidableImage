//
//  SlidableView.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 09.04.2016.
//  Copyright © 2016 Quver. All rights reserved.
//

import UIKit

/// A enum used to determine which direction the slider should slide from
public enum SlideDirection: Int {
  case left
  case right
  case top
  case bottom
}

/// A struct containing border information for the slider. You can use this struct to define the width and color of the slider border.
public struct SlidableImageBorder {
  var borderWidth: CGFloat
  var borderColor: UIColor
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

  /// Struct that tells the slider if there should be a border view added
  open var sliderBorder: SlidableImageBorder? = nil

  private var sliderBorderView: UIView?

  /// Generic initializer with views
  ///
  /// - Parameters:
  ///   - frame: Frame size
  ///   - firstView: First view - should have size equal to frame and second view
  ///   - secondView: Second view - should have size equal to frame and second view
  ///   - slideDirection: Optional parameter for the direction that the slider should slide. The default value is .right.
  ///   - sliderBorder: Optional paramter that will add a border to the slider of the specfied size and color
  public init(frame: CGRect,
              firstView: UIView,
              secondView: UIView,
              sliderImage: UIImage? = nil,
              slideDirection: SlideDirection = .right,
              sliderBorder: SlidableImageBorder? = nil) {
    self.firstView = firstView
    self.secondView = secondView
    self.sliderCircle = SlidableImage.setupSliderCircle(sliderImage: sliderImage)
    self.slideDirection = slideDirection
    self.sliderBorder = sliderBorder
    super.init(frame: frame)

    initializeViews()
    initializeGestureRecognizer()
    initializeBorder()
  }

  /// Short way to initialize SlidableView. You need target size and images.
  ///
  /// - Parameters:
  ///   - frame: Frame size
  ///   - firstImage: First image for sliding
  ///   - secondImage: Second image for sliding
  ///   - slideDirection: Optional parameter for the direction that the slider should slide. The default value is .right.
  ///   - sliderBorder: Optional paramter that will add a border to the slider of the specfied size and color
  convenience public init(frame: CGRect,
                          firstImage: UIImage,
                          secondImage: UIImage,
                          sliderImage: UIImage? = nil,
                          slideDirection: SlideDirection = .right,
                          sliderBorder: SlidableImageBorder? = nil) {
    let firstView = SlidableImage.setup(image: firstImage, frame: frame)
    let secondView = SlidableImage.setup(image: secondImage, frame: frame)

    self.init(frame: frame,
              firstView: firstView,
              secondView: secondView,
              sliderImage: sliderImage,
              slideDirection: slideDirection,
              sliderBorder: sliderBorder)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Typicaly this method is used by gesture recognizer, but you can use it for first state or animations
  ///
  /// - Parameter maskLocation: Position of slider
  open func updateMask(location maskLocation: CGFloat) {
    let rect: CGRect = {
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
    }()
    let path = UIBezierPath(rect: rect)
    let layer = CAShapeLayer()
    layer.path = path.cgPath
    secondView.layer.mask = layer

    switch slideDirection {
    case .left, .right:
      sliderCircle.center.x = maskLocation
    case .top, .bottom:
      sliderCircle.center.y = maskLocation
    }
  }

  /// Private wrapper for setup view
  fileprivate func initializeViews() {
    clipsToBounds = true
    sliderCircle.center = center
    switch slideDirection {
    case .left, .right:
      updateMask(location: center.x)
    case .top, .bottom:
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

    switch slideDirection {
    case .left, .right:
      guard (bounds.minX...bounds.maxX ~= location.x) else { return }
      updateMask(location: location.x)
    case .top, .bottom:
      guard (bounds.minY...bounds.maxY ~= location.y) else { return }
      updateMask(location: location.y)
    }
  }

  /// Private wrapper for images border
  private func initializeBorder() {
    // Only add the slider to the view if a non nil sliderBorder was set
    guard let sliderBorder = sliderBorder else {
      return
    }

    sliderBorderView = UIView()
    sliderBorderView?.translatesAutoresizingMaskIntoConstraints = false
    sliderBorderView?.backgroundColor = sliderBorder.borderColor
    addSubview(sliderBorderView!)
    addConstraints([
      NSLayoutConstraint(item: sliderBorderView!,
                         attribute: .centerX,
                         relatedBy: .equal,
                         toItem: sliderCircle,
                         attribute: .centerX,
                         multiplier: 1.0,
                         constant: 0.0),
      NSLayoutConstraint(item: sliderBorderView!,
                         attribute: .centerY,
                         relatedBy: .equal,
                         toItem: sliderCircle,
                         attribute: .centerY,
                         multiplier: 1.0,
                         constant: 0.0),
      NSLayoutConstraint(item: sliderBorderView!,
                         attribute: .height,
                         relatedBy: .equal,
                         toItem: self,
                         attribute: .height,
                         multiplier: 1.0,
                         constant: 0.0),
      NSLayoutConstraint(item: sliderBorderView!,
                         attribute: .width,
                         relatedBy: .equal,
                         toItem: nil,
                         attribute: .notAnAttribute,
                         multiplier: 1.0,
                         constant: sliderBorder.borderWidth)
      ])
    bringSubview(toFront: sliderCircle)
  }

  /// Private wrapper for setup circle slider view
  ///
  /// - Parameters:
  ///   - image: Content image for slider circle
  /// - Returns: Slider circle
  private class func setupSliderCircle(sliderImage: UIImage? = nil) -> UIView {
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
