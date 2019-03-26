//
//  IntroductionViewController.swift
//  CubeAdventure
//
//  Created by iOS123 on 2019/3/26.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.alpha = 0
        self.containerView.layer.zPosition = 1000
         self.containerView.layer.transform = CATransform3DRotate(self.containerView.layer.transform, CGFloat(Double.pi), 0, 1, 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {
            self.containerView.alpha = 1
            self.containerView.layer.transform = CATransform3DRotate(self.containerView.layer.transform, CGFloat(Double.pi), 0, 1, 0)
        }
    }


    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        UIView.animate(withDuration: 1, animations: {
            self.containerView.layer.anchorPoint = CGPoint.init(x: 0, y: 0)
            self.containerView.layer.anchorPointZ = 0
            self.containerView.layer.transform = CATransform3DRotate(self.containerView.layer.transform, CGFloat(Double.pi), 1, 1, 1)
            self.containerView.alpha = 0
        }, completion: { (Bool) in
            
            self.dismiss(animated: false, completion: nil)
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
