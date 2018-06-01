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
    var collectionV: UICollectionView?
    var selectIndex: NSInteger?
    var fontSize: CGFloat?
    var titleDatas: Array<Any>?
    var bgNomalColor: UIColor?
    var bgSelectColor: UIColor?
    var titleNomalColor: UIColor?
    var titleSelectColor: UIColor?
    var lineNomalColor: UIColor?
    var lineSelectColor: UIColor?
    var indicateLine: UIView?
    
    
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
        
        self.collectionV = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionV?.delegate = self
        collectionV?.dataSource = self
        collectionV?.showsHorizontalScrollIndicator = false
        collectionV?.bounces = false
        self.addSubview(self.collectionV!)
        self.collectionV?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        self.collectionV?.register(JJSegmentViewHeadCell.self, forCellWithReuseIdentifier: "kCell")
    
        //  指示器
        indicateLine = UIView()
        indicateLine?.backgroundColor = .red
        self.collectionV?.addSubview(indicateLine!)
        // 开启线程
        DispatchQueue.main.async {
            // 主线程中
            let size = self.delegate?.segmentViewHeadItemSize(self, 0)
            self.indicateLine?.frame = CGRect(x: 0, y:(size?.height)! - 2, width:(size?.width)!, height: 2)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        self.collectionV?.reloadData()
        self.selectIndex = indexPath.row

        
        var cell = collectionView.cellForItem(at: indexPath)
        if cell == nil {
            collectionView.layoutIfNeeded()
            cell = collectionView.cellForItem(at: indexPath)
            cell!.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        }
        
        UIView.animate(withDuration: 0.4) {
            let indicateLine_frame = CGRect(x: (cell?.frame.origin.x)!, y: (cell?.frame.size.height)! - 2, width: (cell?.frame.size.width)!, height: 2)
            self.indicateLine?.frame = indicateLine_frame
        }
        
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
        self.collectionV?.scrollToItem(at: NSIndexPath(item: index, section: 0) as IndexPath, at: .centeredHorizontally, animated: true)
        self.selectIndex = index
        self.collectionV?.reloadData()
        
        let indexP = IndexPath(item: index, section: 0)
        var cell = collectionV?.cellForItem(at: indexP)
        if cell == nil {
            collectionV?.layoutIfNeeded()
            cell = collectionV?.cellForItem(at: indexP)
            cell!.isSelected = true
            collectionV?.selectItem(at: indexP, animated: true, scrollPosition: .top)
        }
        
        UIView.animate(withDuration: 0.4) {
            let indicateLine_frame = CGRect(x: (cell?.frame.origin.x)!, y: (cell?.frame.size.height)! - 2, width: (cell?.frame.size.width)!, height: 2)
            self.indicateLine?.frame = indicateLine_frame
        }
    }
}
