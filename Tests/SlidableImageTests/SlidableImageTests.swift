import Testing
import SwiftUI
@testable import SlidableImage

@MainActor
struct SlidableImageTests {

    private func makeSUT(axis: Axis = .horizontal) -> SlidableImage<Arrows, Color, Color> {
        SlidableImage(axis: axis, arrows: { Arrows() }, leftView: { Color.red }, rightView: { Color.green })
    }

    // MARK: - Horizontal

    @Test func maskSizeHorizontalWithoutLocation() {
        #expect(makeSUT().maskSize(total: 200) == 100)
    }

    @Test func maskSizeHorizontalWithLocationAtStart() {
        let result = makeSUT().maskSize(total: 200, locationValue: 0)
        #expect(result == 200 - Constants.arrowSize / 2)
    }

    @Test func maskSizeHorizontalWithLocationAtCenter() {
        let result = makeSUT().maskSize(total: 200, locationValue: 100)
        #expect(result == 100 - Constants.arrowSize / 2)
    }

    @Test func maskSizeHorizontalWithLocationAtBoundary() {
        let locationX = 200 - Constants.arrowSize
        let result = makeSUT().maskSize(total: 200, locationValue: locationX)
        #expect(result == Constants.arrowSize / 2)
    }

    // MARK: - Vertical

    @Test func maskSizeVerticalWithoutLocation() {
        #expect(makeSUT(axis: .vertical).maskSize(total: 200) == 100)
    }

    @Test func maskSizeVerticalWithLocationAtStart() {
        let result = makeSUT(axis: .vertical).maskSize(total: 200, locationValue: 0)
        #expect(result == 200 - Constants.arrowSize / 2)
    }

    @Test func maskSizeVerticalWithLocationAtBoundary() {
        let locationY = 200 - Constants.arrowSize
        let result = makeSUT(axis: .vertical).maskSize(total: 200, locationValue: locationY)
        #expect(result == Constants.arrowSize / 2)
    }
}
