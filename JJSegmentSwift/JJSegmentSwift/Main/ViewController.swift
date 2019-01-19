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
        
        let titleDatas = ["0000","1111","2222","3333","4444","5555","6666","7777","8888","9999"]
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)

        let segmentView = JJSegmentView(frame: frame,
                                        delegate: self,
                                        titleDatas: titleDatas,
                                        headTitleColor: UIColor.blue)
        view.addSubview(segmentView)
        
    }
    
}

extension UIViewController: JJSegmentViewDelegate {
    
    // MARK: - JJSegmentViewDelegate
    func segmentSuperViewController() -> (UIViewController) {
        return self
    }
    
    func segmentSubViewControllerWithIndex(_ segment: JJSegmentView, _ index: NSInteger) -> UIViewController {
        switch index {
        case 0:
                let vc = JJBaseViewController()
                vc.view.backgroundColor = UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)
                return vc
        default:
            let vc = JJBaseViewController()
            vc.view.backgroundColor = UIColor(
                red: CGFloat(arc4random()%256)/255.0,
                green: CGFloat(arc4random()%256)/255.0,
                blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)
            return vc
        }
    }
    
    func segmentItemSelectWithIndex(_ segment: JJSegmentView, _ index: NSInteger) {
        print(index)
    }
    
    //默认首次显示第几个item
    func segmentItemDefaultSelect(_ segment: JJSegmentView) -> NSInteger {
        return 0
    }
    

}

