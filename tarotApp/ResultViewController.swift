//
//  ResultViewController.swift
//  tarotApp
//
//  Created by 永井 伸枝 on 2016/05/26.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit
import Foundation

class ResultViewController: UIViewController {
    @IBOutlet weak var numberImageView: UIImageView!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var faceImageView: UIImageView!
    
    @IBAction func backButton(sender: AnyObject) {
    }
    @IBAction func forwardbutton(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initCardView()
        initResultText()
        // Do any additional setup after loading the view.
    }

    //画像の用意
    func initCardView(){
        let cardNum = 0//初期値0にしとく
        
        let numImage:UIImage? = UIImage(named:"num_\(cardNum)")//数字札のイメージ読み込み
        numberImageView.image = numImage//数字札のイメージに貼り付け
        //numberImageView.contentMode = UIViewContentMode.TopRight//位置合わせ
       /* numberImageView.contentMode = UIViewContentMode.ScaleAspectFill */
        initViewShadow(numberImageView)
        
        let nameImage:UIImage? = UIImage(named:"name_u_\(cardNum)")
        nameImageView.image = nameImage
        initViewShadow(nameImageView)
        
        let faceImage:UIImage? = UIImage(named:"face\(cardNum)")
        faceImageView.image = faceImage
        initViewShadow(faceImageView)
    }
    
    //キャプションの用意
    func initResultText(){
        let cardNum = 12
        
        let path = NSBundle.mainBundle().pathForResource("TarotData", ofType: "plist")
        let arr = NSArray(contentsOfFile: path!)
        var caption = ""
        
        if let text = arr![cardNum].objectForKey("captionUpright") as? String{//オプショナルがnilでなければ
            caption = text
        }
        testLabel.text = caption
        initViewShadow(testLabel)
        
    }
    
    func initViewShadow(view :UIView) -> (UIView) {/*基本のドロップシャドウ設定*/
        view.layer.shadowColor =  UIColor.blackColor().CGColor
        view.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        view.layer.shadowOpacity = 0.4 /* 透明度 */
        view.layer.shadowRadius = 5.0 /* 影の距離 */
        return view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
