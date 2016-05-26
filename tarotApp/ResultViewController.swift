//
//  ResultViewController.swift
//  tarotApp
//
//  Created by 永井 伸枝 on 2016/05/26.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var numberImageView: UIImageView!
    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var resultTextView: UITextView!
    
    @IBAction func backButton(sender: AnyObject) {
    }
    @IBAction func forwardbutton(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initCardView()
        // Do any additional setup after loading the view.
    }

    //画像の用意
    func initCardView(){
        let cardNum = 0//初期値0にしとく
        let numImage:UIImage? = UIImage(named:"num_\(cardNum)")//数字札のイメージ読み込み
        numberImageView.image = numImage//数字譜だのイメージに貼り付け
        //numberImageView.contentMode = UIViewContentMode.TopRight//位置合わせ
       /* numberImageView.contentMode = UIViewContentMode.ScaleAspectFill */
        numberImageView.layer.shadowColor =  UIColor.blackColor().CGColor
        numberImageView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        numberImageView.layer.shadowOpacity = 0.4 /* 透明度 */
        numberImageView.layer.shadowRadius = 5.0 /* 影の距離 */

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
