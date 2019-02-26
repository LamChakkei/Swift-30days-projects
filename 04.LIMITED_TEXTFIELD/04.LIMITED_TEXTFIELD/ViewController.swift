//
//  ViewController.swift
//  04.LIMITED_TEXTFIELD
//
//  Created by LamChakkei on 2019/2/25.
//  Copyright © 2019 LamChakkei. All rights reserved.
//

import UIKit
import SnapKit

//状态栏高度加导航栏高度
let totalHeight = UIApplication.shared.statusBarFrame.size.height + 44.0

class ViewController: UIViewController,UITextViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        let leftItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        let rightItem = UIBarButtonItem(title: "Tweet", style: .plain, target: self, action: nil)
        rightItem.tintColor = UIColor.green
        navigationItem.rightBarButtonItem = rightItem
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAdjustFrame(noti:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    //MARK:Config UI
    func configUI() -> Void {
        view.backgroundColor = UIColor.white
        view.addSubview(limitedTextView)
        view.addSubview(remindLbl)
        view.addSubview(avatarImgView)
        
        avatarImgView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.equalTo(view).offset(10)
            ConstraintMaker.top.equalTo(view).offset(totalHeight + 5)
            ConstraintMaker.width.height.equalTo(50)
        }
        
        limitedTextView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.equalTo(avatarImgView.snp.right).offset(10)
            ConstraintMaker.top.equalTo(avatarImgView)
            ConstraintMaker.right.equalTo(view)
            ConstraintMaker.bottom.equalTo(view)
        }
        remindLbl.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.right.equalTo(view).offset(-50)
            ConstraintMaker.top.equalTo(view.snp.bottom).offset(-40)
            ConstraintMaker.width.equalTo(50)
            ConstraintMaker.height.equalTo(40)
        }
    }
    
    @objc func keyboardAdjustFrame(noti:Notification) -> Void {
        let duration = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let endFrame = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        let margin = view.frame.height - y
        UIView.animate(withDuration: duration) {
            //键盘弹出
            if margin > 0 {
                self.remindLbl.transform = CGAffineTransform(translationX: 0,y: -endFrame.size.height)
            }
            //键盘收起
            else {
                self.remindLbl.transform = CGAffineTransform.identity
            }
        }

    }
    
    //MARK:TxtView Delegate
    func textViewDidChange(_ textView: UITextView) {
        self.remindLbl.text = "\(80-textView.text.count)"
    }

    //MARK:Lazy Load
    lazy var limitedTextView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.delegate = self
        return textView
    }()
    
    lazy var remindLbl : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.text = "80"
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    lazy var avatarImgView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()
    
}

