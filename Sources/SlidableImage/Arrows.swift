//
//  Arrows.swift
//  SlidableImage
//

import SwiftUI

public struct Arrows: View {
    private let arrowColor: Color
    private let backgroundColor: Color
    
    public init(arrowColor: Color = .white, backgroundColor: Color = .gray) {
        self.arrowColor = arrowColor
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        HStack(spacing: 5) {
            Triangle()
                .fill(arrowColor)
                .frame(width: 20, height: Constants.arrowSize / 2)
                .rotationEffect(.degrees(180))
            Triangle()
                .fill(arrowColor)
                .frame(width: 20, height: Constants.arrowSize / 2)
        }
        .frame(width: Constants.arrowSize, height: Constants.arrowSize)
        .background(backgroundColor)
        .cornerRadius(Constants.arrowSize / 2)
    }
}

struct ArrowsPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            Arrows()
            Arrows(arrowColor: .green, backgroundColor: .orange)
        }
    }
}
