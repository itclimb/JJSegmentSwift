# JJSegmentSwift
标签控制器swift版

效果图展示如下

![image](http://ouv3b4r5z.bkt.clouddn.com/segment.png)

一个非常简单实用的标签控制器,可快速入手,在项目中使用

```
   let titleDatas = ["推荐视频","热点","直播","阿里巴巴","今日头条","腾讯视频"]
   let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
   let segmentView = JJSegmentView(frame: frame,
                                        delegate: self,
                                        titleDatas: titleDatas,
                                        headTitleColor: UIColor.blue)
   view.addSubview(segmentView)
        
 ```
