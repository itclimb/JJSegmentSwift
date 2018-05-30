//
//  JJSegmentViewHead.swift
//  JJSegmentSwift
//
//  Created by 金剑 on 2018/5/25.
//  Copyright © 2018年 金剑. All rights reserved.
//

import UIKit

protocol JJSegmentViewHeadDelegate {
    func segmentViewHeadNumberOfItems() -> NSInteger
    func segmentViewHeadItemSize(_ segmentViewHead:JJSegmentViewHead,_ index: NSInteger) -> CGSize
    func segmentViewHeadSelectIndexOfItem(_ index: NSInteger)
}

class JJSegmentViewHead: UIView {
    
    var delegate: JJSegmentViewHeadDelegate?
    var collectionView: UICollectionView?
    var selectIndex: NSInteger?
    var fontSize: CGFloat?
    var titleDatas: Array<Any>?
    var bgNomalColor: UIColor?
    var bgSelectColor: UIColor?
    var titleNomalColor: UIColor?
    var titleSelectColor: UIColor?
    var lineNomalColor: UIColor?
    var lineSelectColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect,
                     bgNomalColor: UIColor,
                     bgSelectColor: UIColor,
                     titleNomalColor:UIColor,
                     titleSelectColor:UIColor,
                     lineNomalColor:UIColor,
                     lineSelectColor:UIColor,
                     fontSize:CGFloat,
                     titleDatas:Array<Any>) {
        self.init(frame: frame)
        
        self.bgNomalColor = bgNomalColor
        self.bgSelectColor = bgSelectColor
        self.titleNomalColor = titleNomalColor
        self.titleSelectColor = titleSelectColor
        self.lineNomalColor = lineNomalColor
        self.lineSelectColor = lineSelectColor
        self.fontSize = fontSize
        self.titleDatas = titleDatas
        self.selectIndex = 0
        self.createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        self.addSubview(self.collectionView!)
        self.collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        self.collectionView?.register(JJSegmentViewHeadCell.self, forCellWithReuseIdentifier: "kCell")
    
    }
    
}

extension JJSegmentViewHead: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return (self.delegate?.segmentViewHeadItemSize(self, indexPath.row))!
    }
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectIndex == indexPath.row {
            return
        }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.collectionView?.reloadData()
        self.selectIndex = indexPath.row
        self.delegate?.segmentViewHeadSelectIndexOfItem(indexPath.row)
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.delegate?.segmentViewHeadNumberOfItems())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: JJSegmentViewHeadCell = collectionView.dequeueReusableCell(withReuseIdentifier: "kCell", for: indexPath) as! JJSegmentViewHeadCell
        cell.backgroundColor = .yellow
        cell.titleLabel?.text = self.titleDatas?[indexPath.row] as? String
        cell.fontSize = self.fontSize
        if selectIndex == indexPath.item {
            cell.line?.backgroundColor = lineSelectColor
            cell.titleLabel?.textColor = titleSelectColor
            cell.contentView.backgroundColor = bgSelectColor
        }else {
            cell.line?.backgroundColor = lineNomalColor
            cell.titleLabel?.textColor = titleNomalColor
            cell.contentView.backgroundColor = bgNomalColor
        }
        return cell
    }
    
}

extension JJSegmentViewHead {
    
    func segmentViewHeadItemSetThroughScroll(index: NSInteger) {
        if index > (self.delegate?.segmentViewHeadNumberOfItems())! || index < 0 {
            return
        }
        
        self.collectionView?.scrollToItem(at: NSIndexPath(item: index, section: 0) as IndexPath, at: .centeredHorizontally, animated: true)
        self.selectIndex = index
        self.collectionView?.reloadData()
    }
    
    func reloadData() {
        self.collectionView?.reloadData()
    }
}
