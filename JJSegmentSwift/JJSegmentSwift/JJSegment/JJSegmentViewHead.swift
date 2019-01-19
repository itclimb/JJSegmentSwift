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
    var indicatorLineColor: UIColor?
    var indicatorLine: UIView?
    
    //  指定构造器
    init(frame: CGRect,
         bgNomalColor: UIColor,
         bgSelectColor: UIColor,
         titleNomalColor:UIColor,
         titleSelectColor:UIColor,
         indicatorLineColor:UIColor,
         fontSize:CGFloat,
         titleDatas:Array<Any>,
         selectIndex:NSInteger) {
        super.init(frame: frame)
        
        self.bgNomalColor = bgNomalColor
        self.bgSelectColor = bgSelectColor
        self.titleNomalColor = titleNomalColor
        self.titleSelectColor = titleSelectColor
        self.indicatorLineColor = indicatorLineColor
        self.fontSize = fontSize
        self.titleDatas = titleDatas
        self.selectIndex = selectIndex
        self.createSubViews()
        
    }
    
    //  便利构造器
    convenience init(frame: CGRect,
                     bgColor: UIColor,
                     titleColor:UIColor,
                     indicatorLineColor:UIColor,
                     fontSize:CGFloat,
                     titleDatas:Array<Any>,
                     selectIndex:NSInteger) {
        self.init(frame: frame,
                  bgNomalColor: UIColor.white,
                  bgSelectColor: bgColor,
                  titleNomalColor: UIColor.black,
                  titleSelectColor: titleColor,
                  indicatorLineColor: indicatorLineColor,
                  fontSize: fontSize,
                  titleDatas: titleDatas,
                  selectIndex:selectIndex)
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
        collectionV?.backgroundColor = UIColor.white
        self.addSubview(self.collectionV!)
        self.collectionV?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        self.collectionV?.register(JJSegmentViewHeadCell.self, forCellWithReuseIdentifier: "kCell")
    
        //  指示器
        indicatorLine = UIView()
        indicatorLine?.backgroundColor = indicatorLineColor
        self.collectionV?.addSubview(indicatorLine!)
    
        // 开启线程
        DispatchQueue.main.async {
            // 主线程中
            let size = self.delegate?.segmentViewHeadItemSize(self, self.selectIndex!)
            let cell = self.collectionV?.cellForItem(at: NSIndexPath(row: self.selectIndex!, section: 0) as IndexPath)
            self.indicatorLine?.frame = CGRect(x: (cell?.frame.origin.x)! + 10, y:(size?.height)! - 2, width:(size?.width)! - 20, height: 2)
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
        
        var cell = collectionView.cellForItem(at: indexPath)
        if cell == nil {
            collectionView.layoutIfNeeded()
            cell = collectionView.cellForItem(at: indexPath)
            cell!.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        }
        
        UIView.animate(withDuration: 0.4) {
            let indicateLine_frame = CGRect(x: (cell?.frame.origin.x)!  + 10, y: (cell?.frame.size.height)! - 2, width: (cell?.frame.size.width)! - 20, height: 2)
            self.indicatorLine?.frame = indicateLine_frame
        }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.collectionV?.reloadData()
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
            cell.titleLabel?.textColor = titleSelectColor
            cell.contentView.backgroundColor = bgSelectColor
        }else {
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
        
        var sumWeight:CGFloat = 0
        
        for i in 0...index {
            sumWeight += (self.delegate?.segmentViewHeadItemSize(self, i).width)!
        }
        
        let currentWeight = self.delegate?.segmentViewHeadItemSize(self, index).width
        let currentHeight = self.delegate?.segmentViewHeadItemSize(self, index).height
        
        
        UIView.animate(withDuration: 0.4) {
            let indicateLine_frame = CGRect(x: sumWeight - currentWeight!, y: currentHeight! - 2, width: currentWeight!, height: 2)
            self.indicatorLine?.frame = indicateLine_frame
        }
        
        self.collectionV?.scrollToItem(at: NSIndexPath(item: index, section: 0) as IndexPath, at: .centeredHorizontally, animated: false)
        self.selectIndex = index
        self.collectionV?.reloadData()
        
    }
    
}
