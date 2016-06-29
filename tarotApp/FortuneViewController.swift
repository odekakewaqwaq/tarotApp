//
//  FortuneViewController.swift
//  tarotApp
//
//  Created by 永井 伸枝 on 2016/06/10.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit

class FortuneViewController: UIViewController {
    @IBOutlet weak var backGroundView: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var guruguruFaceView: UIImageView!
    @IBOutlet weak var buttonView: UIView!
    
    let cardImage = UIImage(named:"ura_small")//カード関連の変数
    var cardImageSize = CGSizeMake(1.0, 1.0)
    var cardImageWidth : CGFloat = 0.0
    var cardImageHeight : CGFloat = 0.0
    
    var titleImageArray: Array<UIImage> = []//占い関連の変数
    var titleViewArray: Array<UIImageView> = []
    let guruguruFaceAngle = CGFloat(M_PI * 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitleImageArray()
        initTitleView()
        initGuruGuruFace()
        initCardImageSize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        animateTitleView()
        rotateAnim()
        initCardLayer()
        self.view.bringSubviewToFront(guruguruFaceView)
        self.view.bringSubviewToFront(titleView)
        self.view.bringSubviewToFront(buttonView)
    }

    func initTitleImageArray(){
        for i in 0...5{
            let image = UIImage(named:"char_\(i)")!
            titleImageArray.append(image)
        }
    }
    
    func initTitleView(){
        for i in 0 ..< titleImageArray.count{
            let imageView = UIImageView()
            imageView.image = titleImageArray[i]
            imageView.frame.size = CGSizeMake(titleView.bounds.width, titleView.bounds.height)
            imageView.contentMode = .ScaleAspectFit
            titleViewArray.append(imageView)
            titleView.addSubview(titleViewArray[i])
        }
    }
    
    func initGuruGuruFace(){
        self.guruguruFaceView.transform = CGAffineTransformMakeRotation(guruguruFaceAngle * -0.7)
    }

    func animateTitleView(){//占い中表示のアニメ
        let angle = self.guruguruFaceAngle
        for (i,_) in titleViewArray.enumerate() {
        let num = Double(i)
        UIView.animateWithDuration(0.5, delay: 0.1 * num, options:[.Repeat, .Autoreverse] , animations: {
            () -> Void in
            self.titleViewArray[i].center = CGPoint(x: 100, y: 100)
            }
            , completion: nil)
        }
        
        UIView.animateWithDuration(2, delay: 0, options: [.Repeat, .Autoreverse], animations: {
            () -> Void in
            self.guruguruFaceView.transform = CGAffineTransformMakeRotation(angle)
            }, completion: nil)
    }
    
    func rotateAnim() {
        UIView.animateWithDuration(2, delay: 0, options: [.CurveLinear], animations: {
            let angle = CGFloat(M_PI * 1)
            self.backGroundView.transform = CGAffineTransformRotate(self.backGroundView.transform, angle)
            }, completion: { (flag) in
                self.rotateAnim()
        })
    }
    
    func initCardImageSize(){
        let frameWidth = self.view.frame.width
        let pixelWidth = (self.cardImage?.size.width)!
        let pixelHeight = (self.cardImage?.size.height)!
        let imageAspectRatio = pixelHeight / pixelWidth
        let imageScale : CGFloat = 0.18
        self.cardImageSize = CGSizeMake(frameWidth * imageScale, frameWidth * imageScale * imageAspectRatio)
        self.cardImageWidth = frameWidth * imageScale
        self.cardImageHeight = frameWidth * imageScale * imageAspectRatio
    }
    
    func initCardLayer(){
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = view.bounds
        view.layer.addSublayer(replicatorLayer)
        let card = CALayer()
        card.contents = cardImage?.CGImage
        card.bounds = CGRect(x: 0, y: 0, width:self.cardImageWidth , height:self.cardImageHeight)
        card.position = view.center
        card.zPosition -= 200
        card.shadowOffset = CGSize(width: 1.0, height: 1.0)
        card.shadowOpacity = 0.2
        replicatorLayer.addSublayer(card)
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = view.center.y + 200
        animation.duration = 2
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        card.addAnimation(animation, forKey: "animation")
        
        let rotationAnimation = CABasicAnimation(keyPath:"transform.rotation")
        rotationAnimation.toValue = -2 * M_PI
        rotationAnimation.duration = 7
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        replicatorLayer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
        
        replicatorLayer.instanceCount = 22
        replicatorLayer.instanceDelay = 0.5
        let angle = (2.0 * M_PI)/Double(replicatorLayer.instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0, 0, 50)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
