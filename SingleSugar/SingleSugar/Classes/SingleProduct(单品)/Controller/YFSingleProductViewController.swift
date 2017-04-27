//
//  YFSingleProductViewController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/14.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

let collectionCellName = "YFSingleProductCell"
class YFSingleProductViewController: ViewController {

    //MARK: 定义属性
    
    ///数据源
    var items = [YFSinglePItem]()
    ///collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 175, height: 220)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: kNavigationH, width: kWidth, height: kHeight - kNavigationH - kTabBarH), collectionViewLayout: layout)
        collectionView.register(UINib.init(nibName: collectionCellName, bundle: nil), forCellWithReuseIdentifier: collectionCellName)
        collectionView.backgroundColor = UIColor(hue:0.67, saturation:0.00, brightness:0.95, alpha:1.00)
        return collectionView
    }()
    
    //MARK: 生命周期函数
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        setUI()
        loadData()
    }
}

//MARK: 加载数据
extension YFSingleProductViewController {
    fileprivate func loadData() {
        YFHTTPRequestTool.shareNetTool.singleProductItem {[weak self] (items) in
            self?.items = items
            self?.collectionView.reloadData()
        }
    }
}

//MARK: UI
extension YFSingleProductViewController {
    fileprivate func setUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
}

//MARK: collectionView代理方法
extension YFSingleProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellName, for: indexPath) as! YFSingleProductCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = YFSinglePDetailViewController()
        vc.id = items[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}
