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
    @IBOutlet weak var cardSpacerView: UIView!
    
    var CardNum = Int(arc4random_uniform(22))
    var reversed :Bool = (arc4random_uniform(2) != 0)
    
    @IBAction func backButton(sender: AnyObject) {
    }
    @IBAction func forwardbutton(sender: AnyObject) {
    }
    
   override func viewDidLoad() {
        super.viewDidLoad()
        initCardView(self.CardNum,cardPos: 0)
        initResultText(self.CardNum)
        // Do any additional setup after loading the view.
    }

    func initCardNumber(){
        
    }
    
    //画像の用意
    func initCardView( cardNum: Int, cardPos:Int ){
        
        let numImage:UIImage? = UIImage(named:"num_\(cardNum)")//数字札のイメージ読み込み
        numberImageView.image = numImage//数字札のイメージに貼り付け
        
        let nameImage:UIImage?
        if reversed == true{
            faceImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            nameImage = UIImage(named:"name_r_\(cardNum)")
        }else{
            nameImage = UIImage(named:"name_u_\(cardNum)")
        }

        let faceImage:UIImage? = UIImage(named:"face\(cardNum)")
        faceImageView.image = faceImage

        nameImageView.image = nameImage
        
        //initViewShadow(faceImageView)
        initViewShadow(cardSpacerView)
    }
    
    //キャプションの用意
    func initResultText(cardNum: Int){
        
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
