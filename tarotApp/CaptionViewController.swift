//
//  CaptionViewController.swift
//  tarotApp
//
//  Created by 永井 伸枝 on 2016/06/05.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit

class CaptionViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var cardNum : String = ""
    var captionText : String = ""
    let plistPath = NSBundle.mainBundle().pathForResource("caption", ofType: "plist")
    let captionDic = ["":""]
    
    override func viewDidLoad() {
        initViewShadow(imageView)
        super.viewDidLoad()
        initUIGesture()
        initCaptionArray()
        initCaptionLabel()
    }
    
    func initCaptionArray(){//辞書の呼び出し
        let captionDic = NSDictionary(contentsOfFile: plistPath!)
        print(plistPath)
        self.captionText = (captionDic?.objectForKey("\(cardNum)")?.objectForKey("caption") as? String)!
            print(captionText)
    }

    func initUIGesture(){
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(tapGesture)
        
        let swipeDownGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        swipeDownGesture.numberOfTouchesRequired = 1  // number of fingers
        swipeDownGesture.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownGesture)
        
        let swipeUpGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        swipeUpGesture.numberOfTouchesRequired = 1
        swipeUpGesture.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUpGesture)
        
        let swipeRightGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        swipeUpGesture.numberOfTouchesRequired = 1
        swipeUpGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRightGesture)
        
        let swipeLeftGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        swipeUpGesture.numberOfTouchesRequired = 1
        swipeUpGesture.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeftGesture)
    }
    
    func initCaptionLabel(){
        label.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("cardNum is \(cardNum)")
        let str: String = "face_" + cardNum
        print("Str=\(str)")
        let image =  UIImage(named: str)
        imageView.image = image
        label.text = captionText
    }
    
    func handleTap(sender: UITapGestureRecognizer){
        print("Tapped!")
        if label.hidden {
            label.hidden = false
        } else{
            label.hidden = true
        }
    }
    
    func handleSwipe(sender: UITapGestureRecognizer){
        print("swiped!")
        performSegueWithIdentifier("fromCaptionToCollection", sender: nil)
    }
    
    func initViewShadow(view :UIView) -> (UIView) {/*基本のドロップシャドウ設定*/
        view.layer.shadowColor =  UIColor.blackColor().CGColor
        view.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        view.layer.shadowOpacity = 0.4 /* 透明度 */
        view.layer.shadowRadius = 2.0 /* 影の距離 */
        return view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
