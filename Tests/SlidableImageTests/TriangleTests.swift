import Testing
import SwiftUI
@testable import SlidableImage

struct TriangleTests {

    @Test func pathFitsInRect() {
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let path = Triangle().path(in: rect)
        #expect(path.boundingRect.width <= rect.width)
        #expect(path.boundingRect.height <= rect.height)
    }

    @Test func pathBoundingRectMatchesRect() {
        let rect = CGRect(x: 0, y: 0, width: 50, height: 80)
        let path = Triangle().path(in: rect)
        #expect(path.boundingRect.minX >= rect.minX)
        #expect(path.boundingRect.minY >= rect.minY)
        #expect(path.boundingRect.maxX <= rect.maxX)
        #expect(path.boundingRect.maxY <= rect.maxY)
    }

    @Test func pathWithNonZeroOrigin() {
        let rect = CGRect(x: 10, y: 20, width: 60, height: 80)
        let path = Triangle().path(in: rect)
        #expect(path.boundingRect.minX >= rect.minX)
        #expect(path.boundingRect.minY >= rect.minY)
        #expect(path.boundingRect.maxX <= rect.maxX)
        #expect(path.boundingRect.maxY <= rect.maxY)
    }

    @Test func pathWithZeroSize() {
        let rect = CGRect.zero
        let path = Triangle().path(in: rect)
        #expect(path.boundingRect == .zero)
    }
}
