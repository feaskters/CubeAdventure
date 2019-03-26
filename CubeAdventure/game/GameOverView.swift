//
//  GameOverView.swift
//  PurificationMonsters
//
//  Created by iOS123 on 2019/3/14.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

protocol GameOverProtocol {
    func gameOverViewTouchsBegan(sender:GameOverView);
}

class GameOverView: UIView {

    let titleLabel = UILabel.init()
    var delegate:GameOverProtocol?
    
    lazy var background : UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named:"resultbg"))
        return imageView
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        //初始化背景
        self.background.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(self.background)
        //初始化标题
        if SystemLanguageClass.getCurrentLanguage() == "cn"{
            self.titleLabel.text = "过关"
        }else{
            self.titleLabel.text = "CLEAR"
        }
        self.titleLabel.font = UIFont.init(name: "Marker Felt", size: 48)
        self.titleLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.2705882353, blue: 0.09019607843, alpha: 1)
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.titleLabel.frame = CGRect.init(x: self.frame.width / 2 - 75, y: self.frame.height / 2 - 50, width: 150, height: 100)
        self.addSubview(titleLabel)
        
        //启动特效
        self.labelEffective()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    //标题特效设置
    func labelEffective() {
        //标题晃动效果
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            
            EffectiveClass.rotateAndScale(view: self.titleLabel)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Music.shared().musicPlayEffective()
        delegate?.gameOverViewTouchsBegan(sender: self)
    }
}
