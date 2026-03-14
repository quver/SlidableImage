//
//  SlidableImage.swift
//  SlidableImage
//

import SwiftUI

public struct SlidableImage<ArrowsIcon: View, LeftView: View, RightView: View>: View {
    @State private var location: CGPoint?
    private let axis: Axis
    private let arrows: () -> ArrowsIcon
    private let leftView: () -> LeftView
    private let rightView: () -> RightView

    public init(axis: Axis = .horizontal,
                @ViewBuilder arrows: @escaping () -> ArrowsIcon,
                @ViewBuilder leftView: @escaping () -> LeftView,
                @ViewBuilder rightView: @escaping () -> RightView) {
        self.axis = axis
        self.arrows = arrows
        self.leftView = leftView
        self.rightView = rightView
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: axis == .horizontal ? .leading : .top) {
                rightView()
                leftView()
                    .mask {
                        if axis == .horizontal {
                            HStack {
                                Color.black
                                Spacer(minLength: maskSize(total: geometry.size.width))
                            }
                        } else {
                            VStack {
                                Color.black
                                Spacer(minLength: maskSize(total: geometry.size.height))
                            }
                        }
                    }

                arrows()
                    .frame(width: Constants.arrowSize, height: Constants.arrowSize)
                    .padding(axis == .horizontal ? .leading : .top,
                             locationValue ?? defaultOffset(geometry: geometry))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if axis == .horizontal {
                                    let x = min(max(value.location.x, 0), geometry.size.width - Constants.arrowSize)
                                    location = CGPoint(x: x, y: geometry.size.height / 2)
                                } else {
                                    let y = min(max(value.location.y, 0), geometry.size.height - Constants.arrowSize)
                                    location = CGPoint(x: geometry.size.width / 2, y: y)
                                }
                            }
                    )
            }
        }
    }

    private var locationValue: CGFloat? {
        axis == .horizontal ? location?.x : location?.y
    }

    private func defaultOffset(geometry: GeometryProxy) -> CGFloat {
        axis == .horizontal
            ? geometry.size.width / 2 - Constants.arrowSize / 2
            : geometry.size.height / 2 - Constants.arrowSize / 2
    }

    package func maskSize(total: CGFloat, locationValue: CGFloat? = nil) -> CGFloat {
        guard let value = locationValue ?? self.locationValue else {
            return total / 2
        }

        return total - value - Constants.arrowSize / 2
    }
}

#Preview {
    VStack {
        SlidableImage(arrows: { Arrows() },
                      leftView: { Color.red },
                      rightView: { Color.green })

        SlidableImage(axis: .vertical,
                      arrows: { Arrows() },
                      leftView: { Color.blue },
                      rightView: { Color.orange })
    }
}
