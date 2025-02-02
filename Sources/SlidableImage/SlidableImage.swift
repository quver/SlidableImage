//
//  SlidableImage.swift
//  SlidableImage
//

import SwiftUI

public struct SlidableImage<ArrowsIcon: View, LeftView: View, RightView: View>: View {
    @State private var location: CGPoint?
    private let arrows: () -> ArrowsIcon
    private let leftView: () -> LeftView
    private let rightView: () -> RightView
    
    public init(@ViewBuilder arrows: @escaping () -> ArrowsIcon,
                @ViewBuilder leftView: @escaping () -> LeftView,
                @ViewBuilder rightView: @escaping () -> RightView) {
        self.arrows = arrows
        self.leftView = leftView
        self.rightView = rightView
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                rightView()
                leftView()
                    .mask {
                        HStack {
                            Color.black
                            Spacer(minLength: maskSize(width: geometry.size.width))
                        }
                    }
                
                arrows()
                    .frame(width: Constants.arrowSize, height: Constants.arrowSize)
                    .padding(.leading, location?.x ?? geometry.size.width / 2 - Constants.arrowSize / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                guard value.location.x <= geometry.size.width - Constants.arrowSize else { return }
                                
                                location = CGPoint(x: value.location.x, y: geometry.size.height / 2)
                            }
                    )
            }
        }
    }
    
    private func maskSize(width: CGFloat) -> CGFloat {
        guard let location = location?.x else {
            return width / 2
        }
        
        return width - location - Constants.arrowSize / 2
    }
}

struct SlidableImage_Preview: PreviewProvider {
    static var previews: some View {
        SlidableImage(arrows: { Arrows() },
                      leftView: { Color.red },
                      rightView: { Color.green })
    }
}
