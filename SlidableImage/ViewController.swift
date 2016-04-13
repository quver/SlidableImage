//
//  ViewController.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 09.04.2016.
//  Copyright © 2016 Quver.xyz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 0, y: 0, width: 300, height: 500)
        guard let firstImage = UIImage(named: "photo"),
            let secondImage = UIImage(named: "draw") else { return }

        let slider = SlidableImage(frame: rect, firstImage: firstImage, secondImage: secondImage)

        slider.center = view.center
        view.addSubview(slider)
    }
}

