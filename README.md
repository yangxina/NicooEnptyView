# NicooEnptyView

[![CI Status](https://img.shields.io/travis/504672006@qq.com/NicooEnptyView.svg?style=flat)](https://travis-ci.org/504672006@qq.com/NicooEnptyView)
[![Version](https://img.shields.io/cocoapods/v/NicooEnptyView.svg?style=flat)](https://cocoapods.org/pods/NicooEnptyView)
[![License](https://img.shields.io/cocoapods/l/NicooEnptyView.svg?style=flat)](https://cocoapods.org/pods/NicooEnptyView)
[![Platform](https://img.shields.io/cocoapods/p/NicooEnptyView.svg?style=flat)](https://cocoapods.org/pods/NicooEnptyView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

NicooEnptyView is show when no network, request failed, no data tableList.

    NicooErrorView.showErrorMessage(.noNetwork, on: strongSelf.view, clickHandler: {
    print("Press Screen to request again!")
    })
    NicooErrorView.showErrorMessage(.noNetwork, on: strongSelf.view, topMargin: 100, clickHandler: nil)
    // 暂无数据
    NicooBuildingView.showBuildingView(on: view)
    
    如果代码报错， 可以到 https://github.com/yangxina/code 下载

## Installation

NicooEnptyView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NicooEnptyView'
```

## Author

504672006@qq.com, yangxin@tzpt.com

## License

NicooEnptyView is available under the MIT license. See the LICENSE file for more info.
