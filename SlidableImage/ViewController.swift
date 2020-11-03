//
//  ViewController.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 09.04.2016.
//  Copyright © 2016 Quver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 0, y: 0, width: 300, height: 500)
        let firstImage = UIImage(named: "photo")!
        let secondImage = UIImage(named: "draw")!
        
        let slider = SlidableImage(frame: rect, images: (firstImage, secondImage))
        
        slider.center = view.center
        view.addSubview(slider)
    }
    
}
