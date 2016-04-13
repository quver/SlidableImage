#SlidableImage
[![Build Status](https://travis-ci.org/quver/SlidableImage.svg)](https://travis-ci.org/quver/SlidableImage)
[![Coverage Status](https://coveralls.io/repos/github/quver/SlidableImage/badge.svg?branch=master)](https://coveralls.io/github/quver/SlidableImage?branch=master)
[![codebeat badge](https://codebeat.co/badges/53a20383-39e8-42ee-9df3-56b3bb55cb1d)](https://codebeat.co/projects/github-com-quver-slidableimage)
[![GitHub license](https://img.shields.io/github/license/quver/SlidableImage.svg)]()
[![Platform](https://img.shields.io/cocoapods/p/SlidableImage.svg?style=flat)](http://cocoapods.org/pods/SlidableImage)
[![Version](https://img.shields.io/cocoapods/v/SlidableImage.svg?style=flat)](http://cocoapods.org/pods/SlidableImage)


![](https://raw.githubusercontent.com/quver/SlidableImage/master/Assets/demo.gif)

##Instalation
```ruby
pod 'SlidableImage', '~>1.0'
```

Also you have to add images from Graphics to your's Assets.xcassets catalog as "slider"

* slider.png	
* slider@2x.png	
* slider@3x.png

*This temporary workaround - it will be handled by CocoaPods*

##Using

###Simple way

```swift
let slider = SlidableImage(frame: rect, firstImage: simpleImageOne, secondImage: simpleImageTwo)
view.addSubview(slider)
```

###Advanced way

It doesn't mean hard. This way is more customizable.

```swift
let slider = SlidableImage(frame: rect, firstView: firstSubView, secondView: secondSubView)
view.addSubview(slider)
```

## Author

Paweł Bednorz, Quver.xyz

## License

SlidableImage Lib and Slider graphic are available under the MIT license. See the LICENSE file for more info

Images from [http://www.comicsbeat.com/awesome-infographic-on-the-avengers-then-and-now/](http://www.comicsbeat.com/awesome-infographic-on-the-avengers-then-and-now/)