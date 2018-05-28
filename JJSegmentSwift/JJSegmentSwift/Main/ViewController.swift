//
//  ViewController.swift
//  JJSegmentSwift
//
//  Created by 金剑 on 2018/5/25.
//  Copyright © 2018年 金剑. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "Segment"
        
        let titleDatas = ["推荐视频","热点","直播","阿里巴巴","今日头条","腾讯视频"]
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        let segmentView = JJSegmentView(frame: frame,
                                        delegate: self,
                                    titleDatas: titleDatas,
                                    headHeight: 40,
                                    fontSize: 17,
                                    headBgNomalColor: UIColor.white,
                                    headBgSelectColor: UIColor.white,
                                    headTitleNomalColor: UIColor.black,
                                    headTitleSelectColor: UIColor.blue,
                                    headLineNomalColor: UIColor.black,
                                    headLineSelectColor: UIColor.blue)
        view.addSubview(segmentView)
        
    }
    
}

extension UIViewController: JJSegmentViewDelegate {
    func segmentSuperViewController() -> (UIViewController) {
        return self
    }
    
    func segmentSubViewControllerWithIndex(_ segment: JJSegmentView, _ index: NSInteger) -> UIViewController {
        switch index {
        case 0:
                let vc = JJBaseViewController()
                vc.view.backgroundColor = .blue
                return vc
        default:
            let vc = JJBaseViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)
            return vc
        }
    }
    
    func segmentItemSelectWithIndex(_ segment: JJSegmentView, _ index: NSInteger) {
        print(index)
    }
    

    
}

