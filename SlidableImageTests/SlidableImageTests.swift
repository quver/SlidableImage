//
//  SlidableImageTests.swift
//  SlidableImageTests
//
//  Created by Paweł Bednorz on 03/11/2020.
//  Copyright © 2020 Quver. All rights reserved.
//

import FBSnapshotTestCase
@testable import SlidableImage

final class SlidableImageTests: FBSnapshotTestCase {
    let rect = CGRect(x: 0, y: 0, width: 300, height: 667)
    let firstImage = UIImage(named: "photo")!
    let secondImage = UIImage(named: "draw")!
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    // MARK: - Initialization with images
    
    func testInitializationWithImages() {
        let slider = SlidableImage(frame: rect,
                                   images: (firstImage, secondImage))
        
        XCTAssertEqual(slider.frame, rect, "has wrong frame")
        XCTAssertEqual((slider.views.first as? UIImageView)?.image, firstImage, "has wrong first image")
        XCTAssertEqual((slider.views.second as? UIImageView)?.image, secondImage, "has wrong second image")
        FBSnapshotVerifyView(slider)
    }
    
    func testInitializationWithImagesAndCustomArrow() {
        let sliderImage = UIImage(named: "fake_arrow")!
        let slider = SlidableImage(frame: rect,
                                   images: (firstImage, secondImage),
                                   sliderImage: sliderImage)
        
        XCTAssertEqual(slider.frame, rect, "has wrong frame")
        XCTAssertEqual((slider.views.first as? UIImageView)?.image, firstImage, "has wrong first image")
        XCTAssertEqual((slider.views.second as? UIImageView)?.image, secondImage, "has wrong second image")
        FBSnapshotVerifyView(slider)
    }
    
    // MARK: - Initialization with views
    
    func testInitializationWithViews() {
        let firstView = UIView(frame: rect)
        firstView.backgroundColor = .red
        let secondView = UIView(frame: rect)
        secondView.backgroundColor = .green
        let slider = SlidableImage(frame: rect,
                                   views: (firstView, secondView))
        
        XCTAssertEqual(slider.frame, rect, "has wrong frame")
        XCTAssertEqual(slider.views.first, firstView, "has wrong first view")
        XCTAssertEqual(slider.views.second, secondView, "has wrong second view")
        FBSnapshotVerifyView(slider)
    }
    
    func testInitializationWithViewsAndCustomArrow() {
        let firstView = UIView(frame: rect)
        firstView.backgroundColor = .red
        let secondView = UIView(frame: rect)
        secondView.backgroundColor = .green
        let slider = SlidableImage(frame: rect,
                                   views: (firstView, secondView))
        
        XCTAssertEqual(slider.frame, rect, "has wrong frame")
        XCTAssertEqual(slider.views.first, firstView, "has wrong first view")
        XCTAssertEqual(slider.views.second, secondView, "has wrong second view")
        FBSnapshotVerifyView(slider)
    }
    
    // MARK: - Slide direction
    
    func testInitializationWithImagesAndRightSlideDirection() {
        let slider = SlidableImage(frame: rect,
                                   images: (firstImage, secondImage))
        slider.slideDirection = .right
        
        FBSnapshotVerifyView(slider)
    }
    
    func testInitializationWithImagesAndLeftSlideDirection() {
        let slider = SlidableImage(frame: rect,
                                   images: (firstImage, secondImage))
        slider.slideDirection = .left
        
        FBSnapshotVerifyView(slider)
    }
    
    func testInitializationWithImagesAndTopSlideDirection() {
        let slider = SlidableImage(frame: rect,
                                   images: (firstImage, secondImage))
        slider.slideDirection = .top
        
        FBSnapshotVerifyView(slider)
    }
    
    func testInitializationWithImagesAndBottomSlideDirection() {
        let slider = SlidableImage(frame: rect,
                                   images: (firstImage, secondImage))
        slider.slideDirection = .bottom
        
        FBSnapshotVerifyView(slider)
    }
    
    // MARK: - Border
    
    func testSliderWithBorder() {
        let slider = SlidableImage(frame: rect,
                                   images: (firstImage, secondImage))
        slider.addBorder(width: 20.0, color: .red)
        
        FBSnapshotVerifyView(slider)
    }
    
    func testSliderWithoutBorder() {
        let slider = SlidableImage(frame: rect,
                                   images: (firstImage, secondImage))
        slider.addBorder(width: 20.0, color: .red)
        slider.removeBorder()
        
        FBSnapshotVerifyView(slider)
    }
}
