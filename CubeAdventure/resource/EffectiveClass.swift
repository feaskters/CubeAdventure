//
//  EffectiveClass.swift
//  ColorSynchronization
//
//  Created by iOS123 on 2019/3/15.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class EffectiveClass: NSObject {

    //晃动效果
    class func shade(view:UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            view.transform = CGAffineTransform.init(rotationAngle: 0.2)
        }, completion: { (Bool) in
            UIView.animate(withDuration: 0.5, animations: {
                view.transform = CGAffineTransform.init(rotationAngle: -0.2)
            }, completion: { (Bool) in
                UIView.animate(withDuration: 0.5, animations: {
                    view.transform = CGAffineTransform.init(rotationAngle: 0)
                })
            })
        })
    }
    
    //顺时针旋转效果
    class func rotateLeft(view:UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            view.transform = CGAffineTransform.init(rotationAngle: 180)
        }, completion: { (Bool) in
            UIView.animate(withDuration: 0.5, animations: {
                view.transform = CGAffineTransform.init(rotationAngle: -180)
            }, completion: { (Bool) in
                UIView.animate(withDuration: 0.5, animations: {
                    view.transform = CGAffineTransform.init(rotationAngle: 0)
                })
            })
        })
    }
    
    //旋转放缩效果
    class func rotateAndScale(view:UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            view.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5).concatenating(CGAffineTransform.init(rotationAngle: 0.5))
        }, completion: { (Bool) in
            UIView.animate(withDuration: 0.5, animations: {
            }, completion: { (Bool) in
                UIView.animate(withDuration: 0.5, animations: {
                    view.transform = CGAffineTransform.init(scaleX: 2, y: 2).concatenating(CGAffineTransform.init(rotationAngle: 0))
                })
            })
        })
    }
    
    //翻转效果
    class func reverse(view:UIView){
        view.layer.zPosition = 1000
        UIView.animate(withDuration: 0.5) {
            view.layer.transform = CATransform3DRotate(view.layer.transform, CGFloat(Double.pi), 0, 1, 0)
        }
        
    }
    
    //按钮点击效果
    class func buttonClick(view:UIView){
        UIView.animate(withDuration: 0.1, animations: {
            view.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        }) { (Bool) in
            UIView.animate(withDuration: 0.1) {
                view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }
        }
    }
    
    //花里胡哨的翻页
    class func reversePage(view:UIView){
        view.layer.zPosition = 1000
        UIView.animate(withDuration: 1, animations: {
            view.layer.anchorPoint = CGPoint.init(x: 0, y: 0)
            view.layer.anchorPointZ = 0
            view.layer.transform = CATransform3DRotate(view.layer.transform, CGFloat(Double.pi), 1, 1, 1)
            view.alpha = 0
        })
    }
}
