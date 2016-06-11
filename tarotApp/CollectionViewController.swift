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
    let numberImage:UIImage? = UIImage(named:"index_1")//faceImageView.image = faceImage//数字札のイメージに貼り付け
    
    var faceImageArr: [UIImage?] = []
    var numberImageArr: [UIImage?] = []
    var selectedNum : Int = 2500
    var cardArray : Array<Int> = []//カードの引かれた回数
    var modifiedCardArray : Array<Int> = []//カードの引かれた回数をレイアウトように変えたもの
    var numArray : Array<String> = []//レイアウト用のファイル名インデックスの列
    
    override func viewDidLoad() {
        initCardArray()
        super.viewDidLoad()
        initNumArray()
        initImageArray()
    }
    
    func initCardArray(){//カードの引かれた回数の呼び出し
        let defaults = NSUserDefaults.standardUserDefaults()
        cardArray = (defaults.arrayForKey("cardArray") as? Array<Int>)!
        print("initiarized\(cardArray)")//ここまでが呼び出し、次?行でレイアウト用に
        
        let a = cardArray[0]
        cardArray.removeAtIndex(0)
        cardArray.append(a)
        cardArray.insert( 0, atIndex: 20)
        cardArray.insert( 0, atIndex: 23)
        }
    
    func initNumArray(){//レイアウト用Arrayの設定
        for i in (1 ... 21) {
            numArray.append("\(i)")
        }
        
        numArray.insert( "a", atIndex: 20)
        numArray.insert( "0", atIndex: 22)
        numArray.insert( "b", atIndex: 23)
    }
    
    func modifyArray(){//行列をレイアウト用に組み替え
        
    }
   

    func initImageArray(){
        for i in (0 ... 23) {
            let thumbImageName = "thumb_" + numArray[i]
            faceImageArr.append(UIImage(named:thumbImageName))
        }

        for i in (0 ... 23) {
            let indexImageName = "index_" + numArray[i]
            numberImageArr.append(UIImage(named:indexImageName))
        }
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let testCell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        
        // Tag番号を使ってImageViewのインスタンス生成
        let faceImageView = testCell.contentView.viewWithTag(1) as! UIImageView //タグ1がthumb
        faceImageView.image = faceImageArr[indexPath.row]
        //faceImageView.image = faceImage
        
        let numberImageView = testCell.contentView.viewWithTag(2) as! UIImageView //タグ2がindex
        numberImageView.image = numberImageArr[indexPath.row]
        numberImageView.alpha = 0.7
        if cardArray[indexPath.row] > 0 || indexPath.row == 20 || indexPath.row == 23 {
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
        return numArray.count
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
        print("indexPath is \(indexPath.row)")
        
        if cardArray[selectedNum] > 0 || indexPath.row == 20 || indexPath.row == 23{
            performSegueWithIdentifier("toCaptionView",sender: nil)
        }
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toCaptionView") {
            let captionViewController : CaptionViewController = (segue.destinationViewController as? CaptionViewController)!
            // SubViewController のselectedImgに選択された画像を設定する
            captionViewController.cardNum = numArray[selectedNum]
        }
    }
    
    @IBAction func backToCollectionView(segue: UIStoryboardSegue) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}