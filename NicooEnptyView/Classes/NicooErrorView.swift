//
//  CLErrorView.swift
//  CloudLibrary
//
//  Created by Nicoo on 5/9/2019.
//  Copyright © 2017 TZPT. All rights reserved.
//8
import UIKit
import SnapKit

public enum NicooErrorType: NSInteger {
    case noData = 1              // 数据为空
    case noNetwork              // 网络错误
    case timeout               // 请求超时
    case defaultError          // 未知错误
}

open class NicooErrorView: UIView {

    private let imageView: UIImageView = UIImageView()
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1)
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1)
        return label
    }()
    lazy private var refreshLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.isHidden = true
        label.text = "请点击页面刷新"
        label.textColor = UIColor(red: 175.0/255.0, green: 175.0/255.0, blue: 175.0/255.0, alpha: 1)
        return label
    }()
    private var clickHandler: (() -> Void)?

    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue:244.0/255.0, alpha: 1)
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(label)
        addSubview(refreshLabel)
        layoutPageSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public functions

    /// 默认的两种作物提示
    ///
    /// - Parameters:
    ///   - errorType: 错误类型 （无网络，无数据）
    ///   - view: 父视图
    ///   - topMargin: 顶部间距
    ///   - clickHandler: 点击响应事件句柄
    
    open class func showErrorMessage(_ errorType: NicooErrorType, on view: UIView, topMargin: CGFloat? = nil, clickHandler: (() -> Void)?) {
        removeErrorMeesageFrom(view)

        let errorView = NicooErrorView(frame: view.frame)
        errorView.titleLabel.isHidden = true
        errorView.clickHandler = clickHandler
        if errorType == .noData {
            errorView.imageView.image = SourceImageFound.foundImage(imageName: "GlobalNOData")
            errorView.label.text = "发现0条数据!"
        } else {
            errorView.imageView.image = SourceImageFound.foundImage(imageName: "GlobalNONetwork")
            errorView.label.text = "网络请求失败!"
            errorView.refreshLabel.isHidden = false
            errorView.addGestureRecognizer(UITapGestureRecognizer(target: errorView, action: #selector(NicooErrorView.viewBeenTapped(_:))))
        }
        view.addSubview(errorView)
        errorView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(topMargin ?? 0)
        }
    }
    
    /// 自定义错误提示
    ///
    /// - Parameters:
    ///   - message: 提示语
    ///   - view: 父视图
    ///   - customerTopMargin: 自定义顶部间距
    
    open class func showCustomErrorMessage(_ message: String, on view: UIView, customerTopMargin: CGFloat?) {
        removeErrorMeesageFrom(view)
        
        let errorView = NicooErrorView(frame: view.frame)
        errorView.titleLabel.isHidden = true
        errorView.refreshLabel.isHidden = true
        errorView.imageView.image = SourceImageFound.foundImage(imageName: "GlobalNOData")
        errorView.label.text = message
        view.addSubview(errorView)
        errorView.snp.makeConstraints { (make) in
            make.leading.equalTo(0)
            make.top.equalTo(customerTopMargin ?? 0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
        }
    }

   open class func removeErrorMeesageFrom(_ view: UIView) {
        for subview in view.subviews {
            if subview is NicooErrorView {
                subview.removeFromSuperview()
                break
            }
        }
    }

    // MARK: - User actions
    
    @objc fileprivate func viewBeenTapped(_ gesture: UITapGestureRecognizer) {
        self.clickHandler?()
    }
    
    // MARK: - Private functions

    private func layoutPageSubviews() {
        layoutTitleLabel()
        layoutImageView()
        layoutLabel()
        layoutRefreshBtn()
    }

    private func layoutTitleLabel() {
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.top.equalTo(0)
            make.trailing.equalTo(0)
            make.leading.equalTo(0)
        }
    }
    
    private func layoutImageView() {
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(118)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func layoutLabel() {
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(0)
            make.centerX.equalTo(self.snp.centerX)
        }
    }

    private func layoutRefreshBtn() {
        refreshLabel.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
}
