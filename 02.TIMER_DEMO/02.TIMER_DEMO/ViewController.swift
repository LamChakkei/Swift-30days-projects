//
//  ViewController.swift
//  02.TIMER_DEMO
//
//  Created by LamChakkei on 2019/2/20.
//  Copyright © 2019 LamChakkei. All rights reserved.
//

import UIKit
import SnapKit

let kScreenHeight = UIScreen.main.bounds.height
let kScreenWidth = UIScreen.main.bounds.width

class ViewController: UIViewController {
    private var timer:Timer!
    private var para:Double!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(startButton)
        view.addSubview(endButton)
        view.addSubview(titleLabel)
        configUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK:Config UI
    func configUI() -> Void {
        startButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.bottom.equalTo(view).offset(-70)
            ConstraintMaker.centerX.equalTo(view).offset(-60)
            ConstraintMaker.height.equalTo(currentHeight(height: 200))
            ConstraintMaker.width.equalTo(currentHeight(height: 50))
        }
        endButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.bottom.equalTo(view).offset(-70)
            ConstraintMaker.left.equalTo(startButton.snp.right).offset(30)
            ConstraintMaker.height.equalTo(currentHeight(height: 200))
            ConstraintMaker.width.equalTo(currentHeight(height: 50))
        }
        titleLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(view)
            ConstraintMaker.top.equalTo(view).offset(80)
        }
    }
    func currentHeight(height:CGFloat) -> CGFloat {
        return height/375 * kScreenHeight
    }
    func currentWidth(width:CGFloat) -> CGFloat {
        return width/667 * kScreenHeight
    }
    
    //MARK:Set Timer
    @objc func setTimer() -> Void {
        para = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in
            self.para = self.para + 0.1
            self.titleLabel.text = String.init(format: "%.1f", self.para)
        })
    }
    @objc func cancelTimer() -> Void {
        timer.invalidate()
    }
    
    //MARK:Lazy Load
    lazy var startButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitle("开始", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(setTimer), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var endButton :UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("结束", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(cancelTimer), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var titleLabel:UILabel = {
       let label = UILabel()
        label.text = "预备"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()

}

