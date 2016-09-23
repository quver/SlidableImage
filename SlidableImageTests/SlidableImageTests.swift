//
//  SlidableImageTests.swift
//  SlidableImageTests
//
//  Created by Pawel Bednorz on 09.04.2016.
//  Copyright © 2016 Quver.xyz. All rights reserved.
//

import XCTest
@testable import SlidableImage

class SlidableImageTests: XCTestCase {

  let rect = CGRect(x: 0, y: 0, width: 300, height: 500)

  func testStandardInit() {
    guard let firstRawImage = UIImage(named: "photo"),
      let secondRawImage = UIImage(named: "draw") else {
        XCTFail()
        return
    }

    let slider = SlidableImage(frame: rect, firstImage: firstRawImage, secondImage: secondRawImage)

    XCTAssertNotNil(slider)
    XCTAssertEqual(slider.frame, rect)
  }

  func testAdvancedInit() {

    let firstView = UIView(frame: rect)
    firstView.backgroundColor = .green

    let secondView = UIView(frame: rect)
    secondView.backgroundColor = .red

    let slider = SlidableImage(frame: rect, firstView: firstView, secondView: secondView)

    XCTAssertEqual(slider.frame, rect)
    XCTAssertEqual(slider.firstView, firstView)
    XCTAssertEqual(slider.secondView, secondView)
  }

}
