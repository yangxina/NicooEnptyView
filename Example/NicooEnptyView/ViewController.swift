//
//  ViewController.swift
//  NicooEnptyView
//
//  Created by 504672006@qq.com on 09/19/2018.
//  Copyright (c) 2018 504672006@qq.com. All rights reserved.
//

import UIKit
import NicooEnptyView

class ViewController: UIViewController {

    static let cellReuserId = "cell"
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private lazy var editBarButton: UIBarButtonItem = {
        let barBtn = UIBarButtonItem(title: "清空",  style: .plain, target: self, action: #selector(rightBarButtonClick))
        barBtn.tintColor = UIColor.blue
        barBtn.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
        return barBtn
    }()
    
    private lazy var leftBarButton: UIBarButtonItem = {
        let barBtn = UIBarButtonItem(title: "暂无",  style: .plain, target: self, action: #selector(leftBarButtonClick))
        barBtn.tintColor = UIColor.blue
        barBtn.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
        return barBtn
    }()
    
    private var haveData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editBarButton
        navigationItem.leftBarButtonItem = leftBarButton
        loadSubVies()
        showAlertView()
        
    }
    
    @objc func rightBarButtonClick() {
        // 显示错误信息： 无数据 （清空后）， 网络请求失败
        NicooErrorView.showErrorMessage(.noData, on: view, clickHandler: nil)
        //NicooErrorView.showErrorMessage("What is wrong with you !", on: view, customerTopMargin: 90)
    }

    @objc func leftBarButtonClick() {
        // 暂无数据
        NicooBuildingView.showBuildingView(on: view)
    }
    

}

// MARK: - Private Funcs
private extension ViewController {
    
    func showAlertView() {
        
        let alert = UIAlertController(title: "ReMained", message: "Is requested successed?", preferredStyle: .alert)
        
        let successAction = UIAlertAction(title: "Successed", style: .default) { [weak self] (action) in
            guard let strongSelf = self else { return }
            NicooErrorView.removeErrorMeesageFrom(strongSelf.view)
            strongSelf.haveData = true
            strongSelf.tableView.reloadData()
            
        }
        
        let failedAction = UIAlertAction(title: "Failed", style: .default) { [weak self] (action) in
            guard let strongSelf = self else { return }
            NicooErrorView.showErrorMessage(.noNetwork, on: strongSelf.view, clickHandler: {
                print("Press Screen to request again!")
                NicooErrorView.removeErrorMeesageFrom(strongSelf.view)
                strongSelf.haveData = true
                strongSelf.tableView.reloadData()
            })
            //NicooErrorView.showErrorMessage(.noNetwork, on: strongSelf.view, topMargin: 100, clickHandler: nil)
        }
        
        alert.addAction(successAction)
        alert.addAction(failedAction)
        self.present(alert, animated: false, completion: nil)
    }
    
    
    func loadSubVies() {
        view.addSubview(tableView)
        layoutTableView()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: ViewController.cellReuserId)
    }
    
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return haveData ? 10 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellReuserId, for: indexPath)
        cell.textLabel?.text = "message = \(indexPath.row)"
        return cell
    }
}

// MARK: - layout
extension ViewController {
    
    private func layoutTableView() {
        tableView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
            } else {
                make.edges.equalToSuperview()
            }
        }
    }
    
}



