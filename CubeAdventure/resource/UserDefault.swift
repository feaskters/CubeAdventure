//
//  UserDefault.swift
//  CubeAdventure
//
//  Created by iOS123 on 2019/3/26.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class UserDefault: NSObject {
    
    
    class func setLevel(level:Int,tag:Int){
        var type = "easy"
        switch tag {
        case 0:
            type = "easy"
            break
        case 1:
            type = "normal"
            break
        case 2:
            type = "hard"
            break
        default:
            type = "easy"
        }
        UserDefaults.standard.set(level, forKey: type)
    }
    
    class func getLevel(tag:Int) -> Int{
        var type = "easy"
        switch tag {
        case 0:
            type = "easy"
            break
        case 1:
            type = "normal"
            break
        case 2:
            type = "hard"
            break
        default:
            type = "easy"
        }
        return UserDefaults.standard.integer(forKey: type)
    }
}
