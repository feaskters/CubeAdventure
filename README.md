# CubeExplorer

IOS项目-方块探索者
## 玩法介绍
- 使用方向按钮使你的方块向前移动，并转化其他的方块，当你的方块填满整个空间时，获得胜利！
- 不同的方块有着不同的效果，详情见游戏内方块简介

## 所学技术
- 对之前所学技术的整合使用
- 使用`UserDefaults`和plist共同存放用户数据
- 加深对`CATransform3D`的使用
- 使用以下代码实现了特殊的翻页效果 
  ``` swift 
    UIView.layer.anchorPoint = CGPoint.init(x: 0, y: 0)
    UIView.layer.anchorPointZ = 0
    UIView.layer.transform = CATransform3DRotate(self.containerView.layer.transform, CGFloat(Double.pi), 1, 1, 1)
  ```

## 所用资源
1. 来自[爱给网](http://www.aigei.com/)的图片和音频
2. 公司美工辛苦劳动的作品
