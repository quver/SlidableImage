//
//  ArrowsView.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 18.12.2016.
//  Copyright © 2016 Quver. All rights reserved.
//

import UIKit

class ArrowsView: UIView {

  private typealias FactorTuple = (single: CGFloat, double: CGFloat)

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
    let factor = makeFactor(rect)
    let startPoint = makeStartPoint(rect, side: side, factor: factor)

    let arrow = UIBezierPath()
    arrow.move(to: startPoint)
    arrow.addLine(to: makeBottomPoint(rect, side: side, factor: factor))
    arrow.addLine(to: makeTopPoint(rect, side: side, factor: factor))
    arrow.addLine(to: startPoint)

    let arrowLeftLayer = CAShapeLayer()
    arrowLeftLayer.path = arrow.cgPath
    arrowLeftLayer.fillColor = UIColor.white.cgColor
    layer.addSublayer(arrowLeftLayer)
  }

  private func makeFactor(_ rect: CGRect) -> FactorTuple {
    let factor = rect.width * factorValue

    return (factor, 2 * factor)
  }

  private func makeStartPoint(_ rect: CGRect, side: Side, factor: FactorTuple) -> CGPoint {
    let startPointX: CGFloat = {
      switch side {
      case .left:
        return rect.minX + factor.double
      case .right:
        return rect.maxX - factor.double
      }
    }()

    return CGPoint(x: startPointX, y: rect.midY)
  }

  private func makeBottomPoint(_ rect: CGRect, side: Side, factor: FactorTuple) -> CGPoint {
      switch side {
      case .left:
        return CGPoint(x: (rect.midX - factor.single), y: (rect.minY + factor.double))
      case .right:
        return CGPoint(x: (rect.midX + factor.single), y: (rect.minY + factor.double))
      }
  }

  private func makeTopPoint(_ rect: CGRect, side: Side, factor: FactorTuple) -> CGPoint {
      switch side {
      case .left:
        return CGPoint(x: (rect.midX - factor.single), y: (rect.maxY - factor.double))
      case .right:
        return CGPoint(x: (rect.midX + factor.single), y: (rect.maxY - factor.double))
      }
  }
  
}
