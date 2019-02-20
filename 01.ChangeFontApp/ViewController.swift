//
//  ViewController.swift
//  ChangeFontApp
//
//  Created by LamChakkei on 2019/2/19.
//  Copyright © 2019 LamChakkei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var button = UIButton.init(type: UIButton.ButtonType.custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(_label)
        self.view.addSubview(_button)
        self.printFontName()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func changeTxtFont() -> Void {
        _label.font = UIFont(name: "Noto Nastaliq Urdu", size: 20)
    }
    
}

func printFontName() -> Void {
    let fontNames = UIFont.familyNames
    for fontName in fontNames {
        print("----- \(fontName)")
    }
}

//MARK: -lazy load
lazy var _label : UILabel = {
    let label = UILabel()
    label.frame = CGRect.init(x: self.view.frame.width/2 - 100, y: self.view.frame.height/2 - 10, width: 250, height: 20)
    label.text = "文本字体变更测试用例"
    label.font = UIFont.systemFont(ofSize: 20)
    label.textColor = UIColor.black
    return label
    
}()
lazy var _button : UIButton = {
    button.frame = CGRect.init(x: self.view.frame.width/2 - 100, y: self.view.frame.height/2 + 40, width: 200, height: 30)
    button.setTitle("更改文本字体", for: UIControl.State.normal)
    button.setTitleColor(UIColor.blue, for: UIControl.State.normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    button.addTarget(self, action: #selector(changeTxtFont), for: UIControl.Event.touchUpInside)
    button.layer.borderColor = UIColor.blue.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 10
    return button
}()


