//
//  ArrowsView.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 18.12.2016.
//  Copyright © 2016 Quver. All rights reserved.
//

import UIKit

class ArrowsView: UIView {

  private enum Side {

    case left
    case right

  }

  private let factorValue: CGFloat = 0.05

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    backgroundColor = .clear
  }

  override func draw(_ rect: CGRect) {
    drawCircle(rect)
    drawArrow(rect, side: .right)
    drawArrow(rect, side: .left)
  }

  private func drawCircle(_ rect: CGRect) {
    let circle = UIBezierPath(ovalIn: rect)
    let circleLayer = CAShapeLayer()
    circleLayer.path = circle.cgPath
    circleLayer.fillColor = UIColor.lightGray.cgColor
    circleLayer.shadowColor = UIColor.darkGray.cgColor
    circleLayer.shadowOpacity = 1
    circleLayer.shadowOffset = CGSize.zero
    circleLayer.shadowRadius = 10
    layer.addSublayer(circleLayer)
  }

  private func drawArrow(_ rect: CGRect, side: Side) {
    let factor: CGFloat = rect.width * factorValue
    let doubleFactor = factor * 2

    let startPointX: CGFloat = {
      switch side {
      case .left:
        return rect.minX + doubleFactor
      case .right:
        return rect.maxX - doubleFactor
      }
    }()

    let startPoint = CGPoint(x: startPointX, y: rect.midY)

    let bottomPoint: CGPoint = {
      switch side {
      case .left:
        return CGPoint(x: (rect.midX - factor), y: (rect.minY + doubleFactor))
      case .right:
        return CGPoint(x: (rect.midX + factor), y: (rect.minY + doubleFactor))
      }
    }()

    let topPoint: CGPoint = {
      switch side {
      case .left:
        return CGPoint(x: (rect.midX - factor), y: (rect.maxY - doubleFactor))
      case .right:
        return CGPoint(x: (rect.midX + factor), y: (rect.maxY - doubleFactor))
      }
    }()

    let arrow = UIBezierPath()
    arrow.move(to: startPoint)
    arrow.addLine(to: bottomPoint)
    arrow.addLine(to: topPoint)
    arrow.addLine(to: startPoint)

    let arrowLeftLayer = CAShapeLayer()
    arrowLeftLayer.path = arrow.cgPath
    arrowLeftLayer.fillColor = UIColor.white.cgColor
    layer.addSublayer(arrowLeftLayer)
  }
  
}
