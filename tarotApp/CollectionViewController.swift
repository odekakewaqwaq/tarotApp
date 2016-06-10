//
//  CollectionViewController.swift
//  tarotApp
//
//  Created by 永井 伸枝 on 2016/05/27.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // 画像の名前を配列とする

    let faceImage:UIImage? = UIImage(named:"thumb0")//数字札のイメージ読み込み
    let numberImage:UIImage? = UIImage(named:"index_1")
    //faceImageView.image = faceImage//数字札のイメージに貼り付け
    var faceImageArr: [UIImage?] = []
    var numberImageArr: [UIImage?] = []
    var selectedNum : Int = 2500
    
    func initImageArray(){

        for i in (1 ... 21) {
            faceImageArr.append(UIImage(named:"thumb\(i)"))
        }
        let additionalImage = UIImage(named:"thumb0")
        faceImageArr.insert( additionalImage, atIndex: 8)
        print(faceImageArr)
        //faceImageArr.append(UIImage(named:"thumb0"))
        
        for i in (1 ... 21) {
            numberImageArr.append(UIImage(named:"index_\(i)"))
        }

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initImageArray()//画像取得
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let testCell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        
        // Tag番号を使ってImageViewのインスタンス生成
        let faceImageView = testCell.contentView.viewWithTag(1) as! UIImageView //タグ1がthumb
        faceImageView.image = faceImageArr[indexPath.row]
        //faceImageView.image = faceImage
        
        let numberImageView = testCell.contentView.viewWithTag(2) as! UIImageView //タグ2がindex
        //numberImageView.image = numberImageArr[indexPath.row]
        numberImageView.alpha = 0.5
        if indexPath.row > 15{
            numberImageView.hidden = true
        }
        return testCell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSize:CGFloat = collectionView.frame.size.width * 0.22
        // 正方形で返すためにwidth,heightを同じにする
        return CGSizeMake(cellSize, cellSize)
    }
    
    
    //section 数の設定、今回は１つにセット
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return faceImageArr.count
    }
    
    func collectionView(collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                                 minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        //行間調整
        let linespacing:CGFloat = collectionView.frame.size.width * 0.055
        return linespacing
    }
    
    // Cell が選択された場合
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedNum = indexPath.row
        performSegueWithIdentifier("toCaptionView",sender: nil)
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toCaptionView") {
            let captionViewController : CaptionViewController = (segue.destinationViewController as? CaptionViewController)!
            // SubViewController のselectedImgに選択された画像を設定する
            captionViewController.cardNum = selectedNum
        }
    }
    
    @IBAction func backToCollectionView(segue: UIStoryboardSegue) {
    }
    
    /*
    // Cell が選択された場合
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        print("selected\([indexPath.row])")
        selectedNum = indexPath.row
        print (selectedNum)
        performSegueWithIdentifier("toTestViewController",sender: nil)
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        // segueから遷移先のResultViewControllerを取得する
        let testViewController = segue.destinationViewController as! TestViewController
        // 遷移先のResultViewControllerで宣言しているx, yに値を代入して渡す
        testViewController.cardNum = selectedNum
        print("selected is \(selectedNum)")
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}