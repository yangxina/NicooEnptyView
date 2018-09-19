//
//  EmptyDataStatusView.swift
//  CloudLibrarySwift
//
//  Created by Nicoo on 28/3/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

/*
 Description:
 首页搜索数据为空的时候显示的View

 History:
 */

import UIKit

/**
 首页搜索数据为空的时候显示的View

 - superclass: UIView
 - classdesign: 没有特定设计模式
 - author: Nicoo
 */
protocol EmptyDataStatusViewDelegate: class {
    func errorMessageViewBeenTapped()
}

class EmptyDataStatusView: UIView {

    fileprivate weak var _delegate:EmptyDataStatusViewDelegate?
    weak var delegate: EmptyDataStatusViewDelegate? {
        get {
            return _delegate
        }
        set (newVal) {
            _delegate = newVal
            self.initializeTapGesture()
        }
    }
    
    fileprivate func initializeTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EmptyDataStatusView.viewBeenTapped(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func viewBeenTapped(_ gesture: UITapGestureRecognizer) {
        self._delegate?.errorMessageViewBeenTapped()
    }
}
