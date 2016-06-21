//
//  TopViewController.swift
//  tarotApp
//
//  Created by 永井 伸枝 on 2016/06/10.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit
import Foundation

class TopViewController: UIViewController {
    let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
    let defaults = NSUserDefaults.standardUserDefaults()
    var canDrawCard :Bool = false
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testLifeLabel: UILabel!
    
    //占えない時用ウィンドウ
    var myWindow: UIWindow!
    var myWindowButton: UIButton!
    
    //秒数カウントダウン用スイッチ
    @IBOutlet weak var imageView0: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var infoView: UIImageView!
    @IBOutlet weak var stackViewForSeconds: UIStackView!
    
    //回数用スタックビュー
    @IBOutlet weak var kaisuImageView0: UIImageView!
    @IBOutlet weak var kaisuImageView1: UIImageView!
    
    @IBOutlet weak var stackViewForKaisu: UIStackView!
    
    var numImageArray: Array<UIImage> = []//カウントアップ・ダウン用配列
    let infoViewKaisuImage = UIImage(named:"remainKaisuLabel")
    let infoViewSecondImage = UIImage(named:"remainSecondLabel")
    
    
    @IBAction func uranauButton(sender: AnyObject) {
        if canDrawCard {
            performSegueWithIdentifier("toFortuneView", sender: nil)
        }else{
            makeWindow()
        }
        
    }
    
    // デバッグ用ボタン
    @IBAction func addLifeButton(sender: AnyObject) {
        var life = defaults.integerForKey("lifePoint")
        life += 1

        defaults.setInteger(life, forKey: "lifePoint")
        defaults.synchronize()
        print("Life is \(defaults.integerForKey("lifePoint"))")
        testLifeLabel.text = "残りライフ　\(defaults.integerForKey("lifePoint"))"
    }
    @IBAction func resetLifeButton(sender: AnyObject) {
        var life = defaults.integerForKey("lifePoint")
        life = 0
        defaults.setInteger(life, forKey: "lifePoint")
        defaults.synchronize()
        print("Life is \(defaults.integerForKey("lifePoint"))")
        testLifeLabel.text = "残りライフ　\(defaults.integerForKey("lifePoint"))"
    }

//ビューディドロード
    override func viewDidLoad() {
        infoView.contentMode = .ScaleAspectFit
        stackViewForSeconds.hidden = true
        stackViewForKaisu.hidden = true
        
        myWindow = UIWindow()
        myWindowButton = UIButton()
        
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
        print("date is \(date)")
        
        super.viewDidLoad()
        initCardArray()
        initLifePoint()
        initLastTimeDrewAt()
        initNumImageArray()
        //judgeAnnotation()
        let annotationTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "judgeAnnotation", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
    }
    
    func initNumImageArray(){
        for num in 0...9 {
            numImageArray.append(UIImage(named:"timeNum_\(num)")!)
        }
    }
    
    func initCardArray(){//0が22個の行列つくる
        var cardArray: [Int] = []
        for i in 0...21 {
            cardArray.append(0)
        }

        let dic = ["cardArray": cardArray]
        defaults.registerDefaults(dic)
        defaults.synchronize()
        
        var testArray = defaults.arrayForKey("cardArray")
        //print("FirstViewArray\(testArray)")
    }
    
    func initLifePoint(){
        let lifePoint = 1
        let dic = ["lifePoint": lifePoint]
        defaults.registerDefaults(dic)
        defaults.synchronize()
    }
    
    func initLastTimeDrewAt(){//引いた時刻を記録
        let date_a = calendar.dateWithEra(1, year: 2016, month: 4, day: 20, hour: 2, minute: 27, second: 0, nanosecond: 0)!
        let dic = ["lastTimeDrewAt" : date_a]
        defaults.registerDefaults(dic)
        defaults.synchronize()
    }
    
    func judgeAnnotation(){
        var lifePoint = defaults.integerForKey("lifePoint")
        let lastTimeDrewAt = (defaults.objectForKey("lastTimeDrewAt") as? NSDate)!
        let currentDate = NSDate()
        
        if calendar.isDate(lastTimeDrewAt, inSameDayAsDate: currentDate){
            //print("もう引いた")
        }else{
            if lifePoint < 1{
            lifePoint += 1
            }
        }
        
        if lifePoint > 0{
            canDrawCard = true
            testLabel.text = "今日はあと\(lifePoint)回引けます"
            infoView.image = infoViewKaisuImage
            stackViewForSeconds.hidden = true
            stackViewForKaisu.hidden = false
            testKaisuImage(lifePoint)
        }else{
            canDrawCard = false
            let twentyFourHoursAfter = calendar.dateByAddingUnit(.Day, value: 1, toDate: NSDate(),options: [])!
            let tomorrowDate = calendar.dateBySettingHour(0, minute: 0, second: 0, ofDate: twentyFourHoursAfter, options: [])!
            
            let time = NSDate().timeIntervalSinceDate(tomorrowDate) // 現在時刻と開始時刻の差
            let time2 = abs(Int(time))
            infoView.image = infoViewSecondImage
            testNumImage(time2)
            stackViewForSeconds.hidden = false
            stackViewForKaisu.hidden = true
            testLabel.text = "あと\(time2)秒で引けまぽよ"
        }
    }
    
    func testNumImage(numInt : Int){
        var numArray = Array(count: 5, repeatedValue:0)
        numArray[0] = (numInt % 100000) / 10000
        numArray[1] = (numInt % 10000) / 1000
        numArray[2] = (numInt % 1000) / 100
        numArray[3] = (numInt % 100) / 10
        numArray[4] = (numInt % 10)
        
        imageView0.image = numImageArray[(numArray[0])]
        imageView1.image = numImageArray[(numArray[1])]
        imageView2.image = numImageArray[(numArray[2])]
        imageView3.image = numImageArray[(numArray[3])]
        imageView4.image = numImageArray[(numArray[4])]
    }
    
    func testKaisuImage(numInt : Int){
        let kaisuInt0 = Int((numInt % 100) / 10)
        let kaisuInt1 = Int(numInt % 10)
    
        kaisuImageView0.image = numImageArray[(kaisuInt0)]
        kaisuImageView1.image = numImageArray[(kaisuInt1)]
    }
    
    func makeWindow(){
        
        // 背景を白に設定する.
        myWindow.backgroundColor = UIColor.whiteColor()
        myWindow.frame = CGRectMake(0, 0, self.view.frame.width * 0.9, self.view.frame.height * 0.4)
        myWindow.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
        myWindow.alpha = 0.8
        myWindow.layer.cornerRadius = 20
        
        // myWindowをkeyWindowにする.
        myWindow.makeKeyWindow()
        
        // windowを表示する.
        self.myWindow.makeKeyAndVisible()
        
        // ボタンを作成する.
        myWindowButton.frame = CGRectMake(0, 0, 100, 60)
        myWindowButton.backgroundColor = UIColor.orangeColor()
        myWindowButton.setTitle("戻る", forState: .Normal)
        myWindowButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        myWindowButton.layer.masksToBounds = true
        myWindowButton.layer.cornerRadius = 30
        myWindowButton.layer.position = CGPointMake(self.myWindow.frame.width/2, self.myWindow.frame.height-50)
        //myWindowButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        myWindowButton.addTarget(self, action: Selector("onClickMyButton"), forControlEvents: .TouchUpInside)
        self.myWindow.addSubview(myWindowButton)
        
        // TextViewを作成する.
        let myTextView: UITextView = UITextView(frame: CGRectMake(10, 10, self.myWindow.frame.width - 20, 150))
        myTextView.backgroundColor = UIColor.clearColor()
        myTextView.text = "占いは基本１日一回です"
        myTextView.font = UIFont.systemFontOfSize(CGFloat(15))
        myTextView.textColor = UIColor.blackColor()
        myTextView.textAlignment = NSTextAlignment.Left
        myTextView.editable = false
        
        self.myWindow.addSubview(myTextView)
    }
    
    internal func onClickMyButton() {
            myWindow = nil
    }
    
    @IBAction func backToTop(segue: UIStoryboardSegue) {//戻ってくるセグエの設定
    }



}
