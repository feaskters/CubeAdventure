import UIKit

class BlockView: UIView {
    
    //type == 0-5 -> differentColor
    private var type : Int = 0
    private var position : Dictionary<String,Int>?
    
    private let background = UIImageView.init(image: UIImage.init(named: "1"))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.background.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(background)
    }

    //更新图片状态
    func updateImage() {
        EffectiveClass.reverse(view: self)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + TimeInterval(0.25)) {
            self.background.image = UIImage.init(named: String(self.type))
        }
    }
    
    //设置类型
    func setType(type:Int){
        self.type = type
        updateImage()
    }
    
    //获取类型
    func getType() -> Int{
        return self.type
    }
    
    //设置位置
    func setPosition(x:Int,y:Int) {
        let dic : Dictionary<String,Int> = ["x" : x,
                                            "y" : y]
        self.position = dic
    }
    
    //获取位置
    func getPosition() -> Dictionary<String,Int> {
        return self.position!
    }
    
}
