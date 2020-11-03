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
    private typealias Side = SlidableImage.Direction
    private typealias SidesTuple = (vertical: Side, horizontal: Side)
    
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
    
    private func drawArrow(_ rect: CGRect, side: SlidableImage.Direction) {
        let arrow = makeArrow(rect, side: side)
        
        let arrowLayer = CAShapeLayer()
        arrowLayer.path = arrow.cgPath
        arrowLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(arrowLayer)
    }
    
    private func makeFactor(_ rect: CGRect) -> FactorTuple {
        let factor = rect.width * factorValue
        
        return (factor, 2 * factor)
    }
    
    private func makeStartPoint(_ rect: CGRect, side: SlidableImage.Direction, factor: FactorTuple) -> CGPoint {
        let startPointX: CGFloat = {
            switch side {
            case .left:
                return rect.minX + factor.double
            case .right:
                return rect.maxX - factor.double
            default:
                return 0
            }
        }()
        
        return CGPoint(x: startPointX, y: rect.midY)
    }
    
    private func makePoint(_ rect: CGRect, side: SidesTuple, factor: FactorTuple) -> CGPoint {
        return CGPoint(x: makeX(rect, side: side.horizontal, factor: factor),
                       y: makeY(rect, side: side.vertical, factor: factor))
    }
    
    private func makeX(_ rect: CGRect, side: SlidableImage.Direction, factor: FactorTuple) -> CGFloat {
        switch side {
        case .left:
            return rect.midX - factor.single
        case .right:
            return rect.midX + factor.single
        default:
            return 0
        }
    }
    
    private func makeY(_ rect: CGRect, side: SlidableImage.Direction, factor: FactorTuple) -> CGFloat {
        switch side {
        case .top:
            return rect.minY + factor.double
        case .bottom:
            return rect.maxY - factor.double
        default:
            return 0
        }
    }
    
    private func makeArrow(_ rect: CGRect, side: SlidableImage.Direction) -> UIBezierPath {
        let factor = makeFactor(rect)
        let startPoint = makeStartPoint(rect, side: side, factor: factor)
        
        let arrow = UIBezierPath()
        arrow.move(to: startPoint)
        arrow.addLine(to: makePoint(rect, side: (.bottom, side), factor: factor))
        arrow.addLine(to: makePoint(rect, side: (.top, side), factor: factor))
        arrow.addLine(to: startPoint)
        
        return arrow
    }
    
}
