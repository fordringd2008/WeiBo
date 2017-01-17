//
//  DFComposeTypeView.swift
//  WeiBoTest
//
//  Created by DFD on 2017/1/16.
//  Copyright © 2017年 dfd. All rights reserved.
//

import UIKit

class DFComposeTypeView: UIView {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// 按钮数据数组
    fileprivate let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "WBComposeViewController"],
                               ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                               ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                               ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                               ["imageName": "tabbar_compose_music", "title": "音乐"],
                               ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
    ]
    
    // 实例化方法
    class func composeTypeView() -> DFComposeTypeView {
        
        let nib = UINib.init(nibName: "DFComposeTypeView", bundle: nil)
        
        // 这里代码就会调用 awakeFromNib
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! DFComposeTypeView
        
        v.frame = UIScreen.main.bounds
        
        // 这里需要在 setupUI中添加子控件，要参照父视图的高度，所以要在这句之前设置父视图大小
        v.setupUI()
        
        return v
    }
    
    func show(){
    
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        vc.view.addSubview(self)
        
    }
    
    /// 关闭视图
    @IBAction func close() {
         removeFromSuperview()
//        hideButtons()
    }

    
    @objc func clickButton(){
        print("测试")
    }
}

fileprivate extension DFComposeTypeView {

    func  setupUI() {
        
        // 强制更新布局
        layoutIfNeeded()
        
        // 1. 向 scrollView 添加视图
        let rect = scrollView.bounds
        
        let width = scrollView.bounds.width
        for i in 0..<2 {
            
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            
            // 2. 向视图添加按钮
            addButtons(v: v, idx: i * 6)
            
            // 3. 将视图添加到 scrollView
            scrollView.addSubview(v)
        }
        
        // 4. 设置 scrollView
        // 这里的内容高度为 0 不会影响，只要小于bound.height 就不会滚动，
        scrollView.contentSize = CGSize(width: 2 * width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        // 禁用滚动
        scrollView.isScrollEnabled = false
        
    }
    
    // 向v添加按钮，按钮在数组中的索引从idx开始
    func addButtons(v: UIView, idx: Int){
        
        // 一个视图最多6个
        let count = 6
        
        for i in idx..<(idx+count){
        
            if i >= buttonsInfo.count {
                break
            }
            
            let dict = buttonsInfo[i]
            
            guard let imageName = dict["imageName"],
                let title = dict["title"] else {
                continue
            }
            
            let btn = DFComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            
            v.addSubview(btn)
            
        }
        
        // 准备常量
        
        let btnSize = CGSize(width: 100, height: 100)
        let margin = (v.bounds.width - 3 * btnSize.width) / 4
        
        for (i, button) in v.subviews.enumerated() {
        
            // 一排三个，第二排换行
            let y : CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
            
            let col = i % 3
            
            // x 与 列有关
            let x = CGFloat(col + 1) * margin + CGFloat(col) * btnSize.width
            
            button.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
            
        }
        
        
    }
    

}
