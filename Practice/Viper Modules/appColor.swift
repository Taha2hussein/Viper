//
//  appColor.swift
//  Practice
//
//  Created by A on 6/22/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit
class appColor:NSObject{
    func saveColor(rgb:(CGFloat,CGFloat,CGFloat)){
        let red = rgb.0
        let green = rgb.1
        let blue = rgb.2
        let defaults = UserDefaults.standard
        defaults.set(red, forKey: "Red")
        defaults.set(green, forKey: "Green")
        defaults.set(blue, forKey: "Blue")
        defaults.synchronize()
    }
    
    func fetchColors() ->(CGFloat,CGFloat,CGFloat){
        let red = UserDefaults.standard.value(forKey: "Red")
        let green = UserDefaults.standard.value(forKey: "Green")
        let blue = UserDefaults.standard.value(forKey: "Blue")
        return(red as! CGFloat,green as! CGFloat,blue as! CGFloat)
    }
}
