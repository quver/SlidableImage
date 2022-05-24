//
//  ArrowViewTests.swift
//  SlidableImageTests
//
//  Created by Paweł Bednorz on 03/11/2020.
//  Copyright © 2020 Quver. All rights reserved.
//

import FBSnapshotTestCase
@testable import SlidableImage

final class ArrowViewTests: FBSnapshotTestCase {
    private var arrowsView: ArrowsView!
    
    override func setUp() {
        super.setUp()
        recordMode = false
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        arrowsView = ArrowsView(frame: rect)
    }
    
    func testView() {
        FBSnapshotVerifyView(arrowsView)
    }
    
    func testLayer() {
        FBSnapshotVerifyLayer(arrowsView.layer)
    }
}
