//
//  JJSegmentView.swift
//  JJSegmentSwift
//
//  Created by 金剑 on 2018/5/25.
//  Copyright © 2018年 金剑. All rights reserved.
//

import UIKit
import SnapKit

protocol JJSegmentViewDelegate : NSObjectProtocol {
    //  指明父控制器
    func segmentSuperViewController() -> (UIViewController)
    //  创建子控制器
    func segmentSubViewControllerWithIndex(_ segment:JJSegmentView, _ index:NSInteger) -> UIViewController
    //  点击标签栏标签时
    func segmentItemSelectWithIndex(_ segment:JJSegmentView, _ index: NSInteger)

}

class JJSegmentView: UIView {
    var delegate: JJSegmentViewDelegate?
    var titleDatas: Array<String>?
    var headHeight: CGFloat?
    var fontSize: CGFloat?
    var headBgNomalColor: UIColor?
    var headBgSelectColor: UIColor?
    var headTitleNomalColor: UIColor?
    var headTitleSelectColor: UIColor?
    var headLineNomalColor: UIColor?
    var headLineSelectColor: UIColor?
    var segmentHead:JJSegmentViewHead?
    var scrollView: UIScrollView?
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect,
                  delegate: JJSegmentViewDelegate,
                  titleDatas: Array<Any>,
                  headHeight: CGFloat,
                  fontSize: CGFloat,
                  headBgNomalColor: UIColor,
                  headBgSelectColor: UIColor,
                  headTitleNomalColor: UIColor,
                  headTitleSelectColor: UIColor,
                  headLineNomalColor: UIColor,
                  headLineSelectColor: UIColor)
    {
        self.init(frame: frame)
        self.delegate = delegate
        self.headHeight = headHeight
        self.fontSize = fontSize
        self.headBgNomalColor = headBgNomalColor
        self.headBgSelectColor = headBgSelectColor
        self.headTitleNomalColor = headTitleNomalColor
        self.headTitleSelectColor = headTitleSelectColor
        self.headLineNomalColor = headLineNomalColor
        self.headLineSelectColor = headLineSelectColor
        self.titleDatas = titleDatas as? Array<String>
        
        self.createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        if (self.titleDatas?.count)! <= 0 { return }
        for vc in (self.delegate?.segmentSuperViewController().childViewControllers)! {
            vc .removeFromParentViewController()
        }
        for subView in self.subviews {
            subView .removeFromSuperview()
        }
        
        let segmentHead_frame = CGRect(x: 0, y: 64, width: self.bounds.size.width, height: self.headHeight!)
        segmentHead = JJSegmentViewHead(frame:segmentHead_frame,
                        bgNomalColor: self.headBgNomalColor!,
                        bgSelectColor: self.headBgSelectColor!,
                        titleNomalColor: self.headTitleNomalColor!,
                        titleSelectColor: self.headTitleSelectColor!,
                        lineNomalColor: self.headLineNomalColor!,
                        lineSelectColor: self.headLineSelectColor!,
                        fontSize: self.fontSize!,
                        titleDatas: self.titleDatas!)
        segmentHead?.backgroundColor = .red
        segmentHead?.delegate = self
        self.addSubview(segmentHead!)
        
        let scrollView_frame = CGRect(x: 0, y: segmentHead_frame.size.height + segmentHead_frame.origin.y, width: self.bounds.width, height: self.bounds.height - segmentHead_frame.size.height)
        let scrollView = UIScrollView(frame: scrollView_frame)
        scrollView.backgroundColor = .blue
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        self.addSubview(scrollView)
        self.scrollView = scrollView
        
        var lastView:UIView? = nil
        
        for i in 0..<(self.titleDatas?.count)! {
            let baseVc = self.delegate?.segmentSubViewControllerWithIndex(self, i)
            self.delegate?.segmentSuperViewController().addChildViewController(baseVc!)
            scrollView.addSubview((baseVc?.view)!)
            //  scrollView的布局
            baseVc?.view.snp.makeConstraints({ (make) in
                make.height.width.equalTo(scrollView)
                make.top.bottom.equalTo(scrollView)
                if i == 0 {
                    make.leading.equalTo(scrollView)
                }else {
                    make.leading.equalTo((lastView?.snp.trailing)!)
                    if (i == (self.titleDatas?.count)! - 1) {
                        make.trailing.equalTo(scrollView)
                    }
                }
            })
            lastView = baseVc?.view
        }
    }
}

extension JJSegmentView: JJSegmentViewHeadDelegate {
    func segmentViewHeadNumberOfItems() -> NSInteger {
        return (self.titleDatas?.count)!
    }
    
    func segmentViewHeadItemSize(_ segmentViewHead: JJSegmentViewHead, _ index: NSInteger) -> CGSize {
        var totalLength : CGFloat = 0
        for str in self.titleDatas! {
            let ocStr: NSString = str as NSString
            let strSize = ocStr.size(withAttributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: self.fontSize ?? 17.0)])
            totalLength += strSize.width + 25
        }
        if totalLength < self.bounds.size.width {
            return CGSize(width: self.bounds.size.width/CGFloat((self.titleDatas?.count)!), height: self.headHeight ?? 40)
        }else {
            let subStr = self.titleDatas![index]
            let ocSubStr: NSString = subStr as NSString
            let subStrSize = ocSubStr.size(withAttributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: self.fontSize ?? 17.0)])
            return CGSize(width: subStrSize.width + 25, height: 40)
        }
    }
    
    func segmentViewHeadSelectIndexOfItem(_ index: NSInteger) {
        self.scrollView?.setContentOffset(CGPoint(x: self.bounds.size.width * CGFloat(index), y: 0), animated: false)
        self.delegate?.segmentItemSelectWithIndex(self, index)
    }
}

extension JJSegmentView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.segmentHead?.segmentViewHeadItemSetThroughScroll(index: NSInteger(scrollView.contentOffset.x / self.bounds.size.width))
    }
}
