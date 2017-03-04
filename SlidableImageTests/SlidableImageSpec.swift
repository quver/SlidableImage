//
//  SlidableImageTests.swift
//  SlidableImageTests
//
//  Created by Pawel Bednorz on 09.04.2016.
//  Copyright © 2016 Quver. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import SlidableImage

class SlidableImageSpec: QuickSpec {

  var recordMode = false

  override func spec() {
    let rect = CGRect(x: 0, y: 0, width: 300, height: 667)

    describe("Initialization") {
      context("with coder") {
        it("trows assertion") {
          expect { () -> Void in
            let coder = NSCoder()
            let _ = SlidableImage(coder: coder)
          }.to(throwAssertion())
        }
      }

      context("with images") {
        var slider: SlidableImage!
        var firstImage: UIImage!
        var secondImage: UIImage!

        context("only required parameters") {
          beforeEach {
            firstImage = UIImage(named: "photo")!
            secondImage = UIImage(named: "draw")!
            slider = SlidableImage(frame: rect, images: (firstImage, secondImage))
          }

          it("has correct frame") {
            expect(slider.frame).to(equal(rect))
          }

          it("is initialized") {
            expect(slider).toNot(beNil())
          }

          it("has correct first image") {
            let first = slider.views.first as! UIImageView
            expect(first.image!).to(equal(firstImage))
          }

          it("has correct second image") {
            let second = slider.views.second as! UIImageView
            expect(second.image!).to(equal(secondImage))
          }

          it("has correct screenshot") {
            expect(slider).to(self.recordValidSnapshot())
          }
        }

        context("with custom arrow") {
          var sliderImage: UIImage!

          beforeEach {
            sliderImage = UIImage(named: "fake_arrow")
            slider = SlidableImage(frame: rect, images: (firstImage, secondImage), sliderImage: sliderImage)
          }

          it("is initialized") {
            expect(slider).toNot(beNil())
          }

          it("has custom slider image") {
            expect(slider).to(self.recordValidSnapshot())
          }
        }

        context("with custom slide direction") {
          beforeEach {
            slider = SlidableImage(frame: rect, images: (firstImage, secondImage))
          }

          it("is initialized with right") {
            slider.slideDirection = .right
            expect(slider).to(self.recordValidSnapshot())
          }

          it("is initialized with left") {
            slider.slideDirection = .left
            expect(slider).to(self.recordValidSnapshot())
          }

          it("is initialized with top") {
            slider.slideDirection = .top
            expect(slider).to(self.recordValidSnapshot())
          }

          it("is initialized with bottom") {
            slider.slideDirection = .bottom
            expect(slider).to(self.recordValidSnapshot())
          }
        }
      }

      context("with views") {
        var slider: SlidableImage!
        var firstView: UIView!
        var secondView: UIView!

        context("only required parameters") {
          beforeEach {
            firstView = UIView(frame: rect)
            firstView.backgroundColor = .red
            secondView = UIView(frame: rect)
            secondView.backgroundColor = .green
            slider = SlidableImage(frame: rect, views: (firstView, secondView))
          }

          it("has correct frame") {
            expect(slider.frame).to(equal(rect))
          }

          it("is initialized") {
            expect(slider).toNot(beNil())
          }

          it("has correct first view") {
            expect(slider.views.first).to(equal(firstView))
          }

          it("has correct second image") {
            expect(slider.views.second).to(equal(secondView))
          }

          it("has correct screenshot") {
            expect(slider).to(self.recordValidSnapshot())
          }
        }
      }
    }

    describe("Border") {
      var slider: SlidableImage!

      beforeEach {
        let firstImage = UIImage(named: "photo")!
        let secondImage = UIImage(named: "draw")!
        slider = SlidableImage(frame: rect, images: (firstImage, secondImage))
      }

      it("has border") {
        slider.addBorder(width: 20.0, color: .red)

        expect(slider).to(self.recordValidSnapshot())
      }

      it("hasn't border") {
        slider.addBorder(width: 20.0, color: .red)
        slider.removeBorder()

        expect(slider).to(self.recordValidSnapshot())
      }
    }
  }

}

extension SlidableImageSpec: RecordableSnapshots {}
