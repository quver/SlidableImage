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

  public typealias Images = (first: UIImage, second: UIImage)
  public typealias Views = (first: UIView, second: UIView)

  /// Direction of sliding
  public enum Direction {

    case left
    case right
    case top
    case bottom

  }

  /// Views tuple
  open var views: Views

  /// Circle view with icon for sliding images.
  open var sliderCircle: UIView

  /// Direction of sliding
  open var slideDirection: Direction = .right {
    didSet {
      prepareForInitialize()
      initializeViews()
    }
  }

  /// Describes border with the specfied size and color
  private var sliderBorderView: UIView?

  /// Generic initializer with views
  ///
  /// - Parameters:
  ///   - frame: Frame size
  ///   - views: Views tuple - first view should have size equal to frame and second view
  ///   - slideDirection: Optional - direction that the slider should slide. Default value .right.
  ///   - sliderBorder: Optional - describes border with the specfied size and color
  public init(frame: CGRect,
              views: Views,
              sliderImage: UIImage? = nil) {
    self.views = views
    self.sliderCircle = SlidableImage.Factory.makeSliderCircle(sliderImage: sliderImage)
    super.init(frame: frame)
    initializeViews()
    initializeGestureRecognizer()
  }

  /// Short way to initialize SlidableView. You need target size and images.
  ///
  /// - Parameters:
  ///   - frame: Frame size
  ///   - images: Images tuple
  ///   - slideDirection: Optional - direction that the slider should slide. Default value .right.
  ///   - sliderBorder: Optional - describes border with the specfied size and color
  convenience public init(frame: CGRect,
                          images: Images,
                          sliderImage: UIImage? = nil) {
    let firstView = SlidableImage.Factory.makeContainer(image: images.first, frame: frame)
    let secondView = SlidableImage.Factory.makeContainer(image: images.second, frame: frame)

    self.init(frame: frame,
              views: (firstView, secondView),
              sliderImage: sliderImage)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Typicaly this method is used by gesture recognizer, but you can use it for first state or animations
  ///
  /// - Parameter maskLocation: Position of slider
  open func updateMask(location maskLocation: CGFloat) {
    let mask = Factory.makeMaskRect(for: maskLocation,
                                    bounds: bounds,
                                    slideDirection: slideDirection)
    let path = UIBezierPath(rect: mask)
    let layer = CAShapeLayer()
    layer.path = path.cgPath
    views.second.layer.mask = layer

    switch slideDirection {
    case .left, .right:
      sliderCircle.center.x = maskLocation
    case .top, .bottom:
      sliderCircle.center.y = maskLocation
    }
  }


  /// Add border for slider
  ///
  /// - Parameters:
  ///   - width: border width
  ///   - color: border color
  open func addBorder(width: CGFloat, color: UIColor) {
    let borderView = UIView()
    borderView.translatesAutoresizingMaskIntoConstraints = false
    borderView.backgroundColor = color
    addSubview(borderView)
    setupBorderConstraints(of: borderView, width: width)
    bringSubviewToFront(sliderCircle)

    sliderBorderView = borderView
  }

  /// Remove border from slider
  open func removeBorder() {
    sliderBorderView?.removeFromSuperview()
  }

  fileprivate func initializeViews() {
    clipsToBounds = true
    sliderCircle.center = center
    switch slideDirection {
    case .left, .right:
      updateMask(location: center.x)
    case .top, .bottom:
      updateMask(location: center.y)
    }

    addSubview(views.first)
    addSubview(views.second)
    addSubview(sliderCircle)
  }

  private func initializeGestureRecognizer() {
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureHandler))
    sliderCircle.addGestureRecognizer(panGestureRecognizer)
  }

  @objc private func gestureHandler(_ panGestureRecognizer: UIPanGestureRecognizer) {
    let location = panGestureRecognizer.location(in: views.first)

    switch slideDirection {
    case .left, .right:
      guard bounds.minX...bounds.maxX ~= location.x else {
        return
      }

      updateMask(location: location.x)
    case .top, .bottom:
      guard bounds.minY...bounds.maxY ~= location.y else {
        return
      }

      updateMask(location: location.y)
    }
  }

  private func setupBorderConstraints(of view: UIView, width: CGFloat) {
    let constraintsDefinitions: [(UIView, NSLayoutConstraint.Attribute)] = [
      (sliderCircle, .centerX),
      (sliderCircle, .centerY),
      (self, .height)
    ]

    var constraints = constraintsDefinitions
      .map {
        NSLayoutConstraint(item: view, attribute: $1, relatedBy: .equal, toItem: $0, attribute: $1,
                           multiplier: 1.0, constant: 0.0)
    }
    constraints.append(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal,
                                          toItem: nil,attribute: .notAnAttribute, multiplier: 1.0,
                                          constant: width))

    addConstraints(constraints)
  }

  private func prepareForInitialize() {
    [views.first, views.second].forEach {
      $0.removeFromSuperview()
    }
  }

}
