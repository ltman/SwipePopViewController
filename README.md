# SwipePopViewController

[![Test](https://github.com/ltman/SwipePopViewController/workflows/test/badge.svg)](https://github.com/ltman/SwipePopViewController/actions)
[![Version](https://img.shields.io/cocoapods/v/SwipePopViewController.svg?style=flat)](https://cocoapods.org/pods/SwipePopViewController)
[![License](https://img.shields.io/cocoapods/l/SwipePopViewController.svg?style=flat)](https://cocoapods.org/pods/SwipePopViewController)
[![Platform](https://img.shields.io/cocoapods/p/SwipePopViewController.svg?style=flat)](https://cocoapods.org/pods/SwipePopViewController)

Allows swipe back gesture to be started from anywhere on the screen (not only from the left edge)
<p align="center">
  <img
    height="300px"
    src="https://github.com/ltman/SwipePopViewController/blob/main/Assets/swipe_pop_demo.gif?raw=true"/>
</p>

## Requirements

- iOS 9+
- Swift 5

## Installation
* [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'SwipePopViewController'
```

* [Carthage](https://github.com/Carthage/Carthage):

```ruby
github "ltman/SwipePopViewController"
```

* [Swift Package Manager](https://swift.org/package-manager/):

```swift
dependencies: [
  .package(url: "https://github.com/ltman/SwipePopViewController")
]
```

## Usage

For the `UIViewController` that you want to enable swipe back, just import the library and call `addSwipePopGesture()` in `viewDidLoad`.
```swift
import SwipePopViewController

class YourViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipePopGesture()
    }
}
```

## Background
If you are using `UINavigationController`, you will be able to swipe back to pop the top view controller off the navigation stack by default.

However, there are 3 pain points we found with this default swipe back feature: 
1. iPhone screen is so big that my thumb can't reach the left edge of screen easily.
2. Code will get complicated when you want to disable this swipe back on some specific `UIViewController`.
3. Some app might experience a frame skipping at the beginning of swiping back. 
   This frame skipping is occurred when `UIViewController` has too many task to do during `viewWillAppear`, `viewWillDisappear`.

## License

SwipePopViewController is available under the MIT license. See the LICENSE file for more info.
