
//
//  HomeViewBuilder.swift
//  Practice
//
//  Created by A on 6/21/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit

protocol view:class {
    func getCurrentColor(rgb:(CGFloat,CGFloat,CGFloat)) -> ()
}
protocol useCases:class {
    func onColorChange(rgb: (CGFloat,CGFloat,CGFloat)) -> ()
    func onLoadCurrentColor() -> (CGFloat,CGFloat,CGFloat)
}
class interactor:useCases{
    
    func onLoadCurrentColor() -> (CGFloat, CGFloat, CGFloat) {
         let appColorDoa = appColor()
         let rgb = appColorDoa.fetchColors()
        return rgb
    }
    
  
    func onColorChange(rgb: (CGFloat, CGFloat, CGFloat)) {
       let appColorDoa = appColor()
        appColorDoa.saveColor(rgb: rgb)
    }
    
}
protocol  wireframe: class {
    var viewController : UIViewController? { get }
    var loginViewController : UIViewController? { get }
    
}

class router: wireframe{
    
    var viewController: UIViewController?
    var loginViewController : UIViewController?

}
protocol  presentation: class {
    var view: view? { get }
    var router : wireframe? {get}
    var interactor: useCases? { get }
    
    func saveColor (rgb:(CGFloat,CGFloat,CGFloat)) -> ()
    
    func loadCurrentColor() -> ()
}
class presenter : presentation{
    
     weak var view: view?
    var router: wireframe?
    var interactor: useCases?
    
    func saveColor(rgb: (CGFloat, CGFloat, CGFloat)) {
       
        DispatchQueue.global(qos: .background).async {[weak self] in

            guard let `self` = self else{return}
            self.interactor?.onColorChange(rgb: rgb )
            print("RGB \(rgb)")
          }
       }
    func loadCurrentColor() -> () {
        DispatchQueue.global(qos: .background).async {[weak self] in
            guard let `self` = self else{return}
            let regb = self.interactor?.onLoadCurrentColor()
            DispatchQueue.main.async {
                self.view?.getCurrentColor(rgb: regb!)
            }
        }
    }
}

class HomeViewBuilder{
    static func assembleModule() -> UIViewController?{
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewInstance = storyBoard.instantiateViewController(withIdentifier: "ViewController")as? ViewController
        let presenterInstance = presenter()
        let interactorInstance  = interactor()
        let routerInstance  = router()
        
        viewInstance?.presenter = presenterInstance
        
        presenterInstance.interactor = interactorInstance
        presenterInstance.router = routerInstance
        presenterInstance.view = viewInstance
        
        routerInstance.viewController = viewInstance

        return viewInstance
    }
}
   



