//
//  ViewController.swift
//  Practice
//
//  Created by A on 6/11/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit


protocol sliderChangeColor {
    func onChangeClolor()
}
class ViewController: UIViewController {

     var presenter : presentation?
    
    @IBOutlet weak var redSliderOutlet: UISlider!
    
    @IBOutlet weak var greenSliderOutlet: UISlider!
    
    @IBOutlet weak var blueSliderOutlet: UISlider!
    
    @IBOutlet weak var rgbLabelChange: UILabel!
    
    
    // mark :- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        onLoadCurrentClolrs()
    }
  
    @IBAction func onRedChangeColor(_ sender: Any) {
        onChangeClolor()
    }
    @IBAction func onGreenChangeColor(_ sender: Any) {
        onChangeClolor()
    }
    @IBAction func onBlueChangeColor(_ sender: Any) {
        onChangeClolor()
    }
    
    
}

extension ViewController: view{
    func onLoadCurrentClolrs(){
           
           presenter?.loadCurrentColor()
           
       }
    func getCurrentColor(rgb: (CGFloat, CGFloat, CGFloat)) {
        let red = rgb.0
        let green = rgb.1
        let blue = rgb.2
        self.view.backgroundColor = UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
          redSliderOutlet.value = Float(red)
          greenSliderOutlet.value = Float(green)
          blueSliderOutlet.value = Float(blue)
         self.rgbLabelChange.text = "(RGB \(red) ,\(green),\(blue))"
    }
    
   
    
}



extension ViewController : sliderChangeColor{
    func onChangeClolor() {
        let rounded  : Float = 1.0
        let red = CGFloat(round(redSliderOutlet.value / rounded) * rounded)
        let green = CGFloat(round(greenSliderOutlet.value / rounded) * rounded)
        let blue = CGFloat(round(blueSliderOutlet.value / rounded) * rounded)
        
        self.rgbLabelChange.text = "(RGB \(red) ,\(green),\(blue))"
        self.view.backgroundColor = UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
        sendColorToPresenter(rgb: (red, green, blue))
    }
    
    func sendColorToPresenter(rgb :(CGFloat,CGFloat,CGFloat)){
        presenter?.saveColor(rgb: rgb)
    }
    
}
