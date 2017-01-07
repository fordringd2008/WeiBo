//
//  DFStatue.swift
//  WeiBoTest
//
//  Created by DFD on 2016/12/27.
//  Copyright © 2016年 dfd. All rights reserved.
//

import UIKit

class DFStatue: NSObject {
    
    /// Int 类型，在 64 位是64位，在 32位机器就是32位
    /// 如果不行 Int64, 在 iPad 2, iPhone5, 5C， 4 上不能正常运行
    var id : Int64 = 0
    
    /// 微博信息内容
    var text: String? = ""
    
    /// 微博的用户 - 注意和服务器返回的 KEY 要一致 因为 返回的这个微博JSon中含有一个 user的对象
    var user: DFUser?
    
    
    /// 重写计算性属性
    override var description: String{
        return yy_modelDescription()
    }
    
}
