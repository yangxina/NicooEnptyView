//
//  CLBuildingView.swift
//  CloudLibrary
//
//  Created by Nicoo on 2017/11/29.
//  Copyright © 2017年 TZPT. All rights reserved.
//

import UIKit
import SnapKit

open class NicooBuildingView: UIView {

    private let imageView = UIImageView.init(image:SourceImageFound.foundImage(imageName: "GlobalBuildingIcon") )
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1)
        label.text = "暂无数据"
        return label
    }()
    
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue:244.0/255.0, alpha: 1)
        addSubview(imageView)
        addSubview(label)
        layoutPageSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    
  open class func showBuildingView(on view: UIView) {
        let buildingView = NicooBuildingView(frame: view.frame)
        view.addSubview(buildingView)
        buildingView.snp.makeConstraints { (make) in
            make.leading.equalTo(0)
            make.top.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    // MARK: - Private functions
    
    private func layoutPageSubviews() {
        layoutImageView()
        layoutLabel()
    }
    
    private func layoutImageView() {
        let imageLeading = UIScreen.main.bounds.size.width/2.0 - (imageView.image?.size.width)!/3.0
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(90)
            make.leading.equalTo(imageLeading)
        }
    }
    
    private func layoutLabel() {
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
        }
    }

}
class SourceImageFound: NSObject {
    
    class func foundImage(imageName: String) -> UIImage {
        let bundleB  = Bundle(for: self.classForCoder()) //先找到最外层Bundle
        let resrouseURL = bundleB.url(forResource: "NicooEnptyView", withExtension: "bundle")
        let bundle = Bundle(url: resrouseURL!) // 根据URL找到自己的Bundle
        let image = UIImage.init(named: imageName, in: bundle , compatibleWith: nil) //在自己的Bundle中找图片
        return image!
    }
}
