import Testing
import SwiftUI
@testable import SlidableImage

@MainActor
struct SlidableImageTests {

    private func makeSUT() -> SlidableImage<Arrows, Color, Color> {
        SlidableImage(arrows: { Arrows() }, leftView: { Color.red }, rightView: { Color.green })
    }

    @Test func maskSizeWithoutLocation() {
        #expect(makeSUT().maskSize(width: 200) == 100)
    }

    @Test func maskSizeWithLocationAtStart() {
        let result = makeSUT().maskSize(width: 200, locationX: 0)
        #expect(result == 200 - Constants.arrowSize / 2)
    }

    @Test func maskSizeWithLocationAtCenter() {
        let result = makeSUT().maskSize(width: 200, locationX: 100)
        #expect(result == 100 - Constants.arrowSize / 2)
    }

    @Test func maskSizeWithLocationAtBoundary() {
        let locationX = 200 - Constants.arrowSize
        let result = makeSUT().maskSize(width: 200, locationX: locationX)
        #expect(result == Constants.arrowSize / 2)
    }
}
