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
    
    var titleImageArray: Array<UIImage> = []
    var titleViewArray: Array<UIImageView> = []
    let guruguruFaceAngle = CGFloat(M_PI * 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitleImageArray()
        initTitleView()
        initGuruGuruFace()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        animateTitleView()
        rotateAnim()
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

    
    func animateTitleView(){
        let angle = self.guruguruFaceAngle
        for (i,a) in titleViewArray.enumerate() {
        let num = Double(i)
        UIView.animateWithDuration(0.5, delay: 0.1 * num, options:[.Repeat, .Autoreverse] , animations: {
            () -> Void in
            self.titleViewArray[i].center = CGPoint(x: 0, y: 100)
            }
            , completion: nil)
        }
        
        UIView.animateWithDuration(2, delay: 0, options: [.Repeat, .Autoreverse], animations: {
            () -> Void in
            self.guruguruFaceView.transform = CGAffineTransformMakeRotation(angle)
            }, completion: nil)
    }
    
    func rotateAnim() {
        
        UIView.animateWithDuration(2, animations: {
            let angle = CGFloat(M_PI * 1)
            self.backGroundView.transform = CGAffineTransformRotate(self.backGroundView.transform, angle)
            }, completion: { (flag) in
                self.rotateAnim()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
