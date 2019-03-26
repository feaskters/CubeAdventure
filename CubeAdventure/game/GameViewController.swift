//
//  GameViewController.swift
//  PurificationMonsters
//
//  Created by iOS123 on 2019/3/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,GameOverProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gameView: UIView!
    
    @IBOutlet weak var controllerView: UIView!
    /*
     tag == 0 -> normal
     tag == 1 -> random
     tag == 2 -> hard
     */
    private var tag = 0;
    private var level = 1;
    private var blocksArray : Array<Array<BlockView>> = Array<Array<BlockView>>.init()
    private var blocksSteped : BlockView? //已被选中的方块
    private var length : CGFloat = 9;
    private var can_click = true //是否可以点击按钮
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titleLabel.text = String(self.level + 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addBlocks()

    }
    
    //页面方块初始化
    /*0 -> 墙壁
      1 -> 路
     -1 -> 起始点/已走过的路
      2 -> 隔板
      3 -> 双重通道
     */
    func addBlocks() {
        //适配ipad
        if UIScreen.main.bounds.width <= 400 {
            self.gameView.frame = CGRect.init(x: 10, y: self.gameView.frame.origin.y, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 20)
        }
        let scSquare : CGFloat = self.gameView.frame.width
        let blockSquare : CGFloat = scSquare / self.length
        
        let levelArray = ((Checkpoints.shared().checkPointsArray[self.tag] as! Array<Any>)[self.level] as! Dictionary<String,Any>)["blocks"]! as! Array<Array<Int>>
        
        for i in 0...Int(self.length) - 1 {
            self.blocksArray.append([])
            for j in 0...Int(self.length) - 1{
                let block = BlockView.init(frame: CGRect.init(x: CGFloat(j) * blockSquare, y: CGFloat(i) * blockSquare, width: blockSquare, height: blockSquare))
                block.setPosition(x: j, y: i)
                block.setType(type: levelArray[i][j])
                self.blocksArray[i].append(block)
                if levelArray[i][j] == -1{
                    self.blocksSteped = block
                }
                self.gameView.addSubview(block)
            }
        }
    }
    
    /*sender.tag
     0 -> 上
     1 -> 左
     2 -> 下
     3 -> 右
     4 -> 重开*/
    @IBAction func buttonClick(_ sender: UIButton) {
        guard self.can_click else {
            return
        }
        Music.shared().musicPlayEffective()
        EffectiveClass.buttonClick(view: sender)
        switch sender.tag {
        case 0:
            self.up(block: self.blocksSteped!)
            break
        case 1:
            self.left(block: self.blocksSteped!)
            break
        case 2:
            self.down(block: self.blocksSteped!)
            break
        case 3:
            self.right(block: self.blocksSteped!)
            break
        case 4:
            self.restart()
            break
        default:
            break
        }
    }
    
    func left(block:BlockView) {
        self.can_click = false
        let x = block.getPosition()["x"]!
        let y = block.getPosition()["y"]!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TimeInterval(0.1)) {
            if x > 0{
                let nextBlock = self.blocksArray[y][x - 1]
                if nextBlock.getType() == 1{
                    nextBlock.setType(type: -1)
                    self.blocksSteped = nextBlock
                    self.left(block: nextBlock)
                }else if nextBlock.getType() == 3{
                    nextBlock.setType(type: 1)
                    self.blocksSteped = nextBlock
                    self.left(block: nextBlock)
                }else if nextBlock.getType() == 2{
                    self.can_click = true
                    nextBlock.setType(type: 1)
                }else{
                    self.can_click = true
                    self.judgeEnd()
                }
            }else{
                self.can_click = true
                self.judgeEnd()
            }
        }
    }
    
    func right(block:BlockView) {
        self.can_click = false
        let x = block.getPosition()["x"]!
        let y = block.getPosition()["y"]!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TimeInterval(0.1)) {
        if x < Int(self.length) - 1{
            let nextBlock = self.blocksArray[y][x + 1]
            if nextBlock.getType() == 1{
                nextBlock.setType(type: -1)
                self.blocksSteped = nextBlock
                self.right(block: nextBlock)
            }else if nextBlock.getType() == 3{
                nextBlock.setType(type: 1)
                self.blocksSteped = nextBlock
                self.right(block: nextBlock)
            }else if nextBlock.getType() == 2{
                self.can_click = true
                nextBlock.setType(type: 1)
            }else{
                self.can_click = true
                self.judgeEnd()
            }
        }else{
            self.can_click = true
            self.judgeEnd()
            }
        }
        
    }
    
    func up(block:BlockView) {
        self.can_click = false
        let x = block.getPosition()["x"]!
        let y = block.getPosition()["y"]!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TimeInterval(0.1)) {
        if y > 0{
            let nextBlock = self.blocksArray[y - 1][x]
            if nextBlock.getType() == 1{
                nextBlock.setType(type: -1)
                self.blocksSteped = nextBlock
                self.up(block: nextBlock)
            }else if nextBlock.getType() == 3{
                nextBlock.setType(type: 1)
                self.blocksSteped = nextBlock
                self.up(block: nextBlock)
            }else if nextBlock.getType() == 2{
                self.can_click = true
                nextBlock.setType(type: 1)
            }else{
                
                self.can_click = true
                self.judgeEnd()
            }
        }else{
            self.can_click = true
            self.judgeEnd()
            }
        }
    }
    
    func down(block:BlockView) {
        self.can_click = false
        let x = block.getPosition()["x"]!
        let y = block.getPosition()["y"]!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TimeInterval(0.1)) {
        if y < Int(self.length) - 1{
            let nextBlock = self.blocksArray[y + 1][x]
            if nextBlock.getType() == 1{
                nextBlock.setType(type: -1)
                self.blocksSteped = nextBlock
                self.down(block: nextBlock)
            }else if nextBlock.getType() == 3{
                nextBlock.setType(type: 1)
                self.blocksSteped = nextBlock
                self.down(block: nextBlock)
            }else if nextBlock.getType() == 2{
                self.can_click = true
                nextBlock.setType(type: 1)
            }else{
                self.can_click = true
                self.judgeEnd()
            }
        }else{
            self.can_click = true
            self.judgeEnd()
            }
        }
    }
    
    func restart() {
        var x = 0
        var y = 0
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { (Timer) in
            EffectiveClass.buttonClick(view: self.blocksArray[y][x])
            UIView.animate(withDuration: 0.05, animations: {
                self.blocksArray[y][x].alpha = 0
                self.blocksArray[y][x].transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
                
                self.blocksArray[x][y].alpha = 0
                self.blocksArray[x][y].transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            }, completion: { (Bool) in
                self.blocksArray[y][x].removeFromSuperview()
                if x != y {
                    self.blocksArray[x][y].removeFromSuperview()
                }
                if y == 8 && x == 8{
                    self.blocksArray.removeAll()
                    self.addBlocks()
                }
            })
            if x < 8 {
                x += 1
            }
            if x == 8 && y < 8{
                x = 0
            }
            if y < 8 && x == 0{
                y += 1
            }
            if x == 8 && y == 8{
                Timer.invalidate()
            }
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        //退出动画
        UIView.animate(withDuration: 1, animations: {
            self.containerView.alpha = 0
            let trans = CGAffineTransform.init(scaleX: 0.0001, y: 0.0001)
            let trans2 = CGAffineTransform.init(rotationAngle: -2.5)
            let t = trans.concatenating(trans2)
            self.containerView.transform = t
        }) { (Bool) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func setTag(tag:Int) {
        self.tag = tag
    }
    func setLevel(level:Int ) {
        self.level = level
    }
    
    //判断结束
    func judgeEnd() {
        var flag = true //是否结束
        for items in self.blocksArray{
            for item in items{
                if item.getType() != -1 && item.getType() != 0{
                    flag = false
                }
            }
        }
        if flag{
            self.gameOver()
        }
    }
    
    //弹出结算页面
    func gameOver() {
        UserDefault.setLevel(level: self.level + 1, tag: self.tag)
        self.controllerView.isUserInteractionEnabled = false
        let gov = GameOverView.init(frame: CGRect.init(x: 0, y: -300, width: self.containerView.frame.width, height: 300))
        gov.delegate = self
        self.view.addSubview(gov)
        UIView.animate(withDuration: 0.2) {
            gov.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.height / 2 - 150, width: self.containerView.frame.width, height: 300)
        }
    }
    
    //代理方法，游戏结束点击事件
    func gameOverViewTouchsBegan(sender:GameOverView) {
        self.back(UIButton.init())
        UIView.animate(withDuration: 0.2) {
            sender.frame = CGRect.init(x: 0, y: -300, width: self.containerView.frame.width, height: 300)
        }
    }
}
