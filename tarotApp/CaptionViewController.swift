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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIGesture()
        initCaption()
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
        
    }
    
    func initCaption(){
        label.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("cardNum is \(cardNum)")
        let str: String = "face_" + cardNum
        print("Str=\(str)")
        label.text = str
        let image =  UIImage(named: str)
        imageView.image = image
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
    //fromCaptionToCollection
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
