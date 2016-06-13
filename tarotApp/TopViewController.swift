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
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testLifeLabel: UILabel!
    @IBOutlet weak var testRemainSecondLabel: UILabel!
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

    
    
    override func viewDidLoad() {
        let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
        print("date is \(date)")
        
        super.viewDidLoad()
        initCardArray()
        initLifePoint()
        initLastTimeDrewAt()
        checkLifePoint()
        drawAnnotation()
        calcTime()
        judgeAnnotation()
        let testTime = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "calcTime", userInfo: nil, repeats: true)
        let annotationTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "judgeAnnotation", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
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
    
    func checkLifePoint(){
        let lifePoint = defaults.integerForKey("lifePoint")
        print("LifePoint is \(lifePoint)")
    }
    
    func drawAnnotation(){
        let date_b = (defaults.objectForKey("lastTimeDrewAt") as? NSDate)!
        print("Last time drew at \(date_b)")
        let currentDate = NSDate()
        print("Current date is \(currentDate)")
        if calendar.isDate(date_b, inSameDayAsDate: currentDate){
            print("もう引いた")
            testLabel.text = "もう引いた"
        }else{
            print("まだ引いてない")
            testLabel.text = "まだ引いてない"
        }
    }
    
    func judgeAnnotation(){
        var lifePoint = defaults.integerForKey("lifePoint")
        let lastTimeDrewAt = (defaults.objectForKey("lastTimeDrewAt") as? NSDate)!
        let currentDate = NSDate()
        
        if calendar.isDate(lastTimeDrewAt, inSameDayAsDate: currentDate){
            //print("もう引いた")
        }else{
            lifePoint += 1
            //print("まだ引いてない")
        }
        
        if lifePoint > 0{
            testLabel.text = "今日はあと\(lifePoint)回引けます"
            //今日はあとn回引ける
        }else{
            let twentyFourHoursAfter = calendar.dateByAddingUnit(.Day, value: 1, toDate: NSDate(),options: [])!
            let tomorrowDate = calendar.dateBySettingHour(0, minute: 0, second: 0, ofDate: twentyFourHoursAfter, options: [])!
            
            let time = NSDate().timeIntervalSinceDate(tomorrowDate) // 現在時刻と開始時刻の差
            let time2 = abs(Int(time))
            testLabel.text = "あと\(time2)秒で引けます"
        }
    }
    
    func calcTime(){
        let twentyFourHoursAfter = calendar.dateByAddingUnit(.Day, value: 1, toDate: NSDate(),options: [])!
        let tomorrowDate = calendar.dateBySettingHour(0, minute: 0, second: 0, ofDate: twentyFourHoursAfter, options: [])!
        
        let time = NSDate().timeIntervalSinceDate(tomorrowDate) // 現在時刻と開始時刻の差
        let time2 = abs(Int(time))
        testRemainSecondLabel.text = "あと\(time2)秒"
        
    }
    
    @IBAction func backToTop(segue: UIStoryboardSegue) {//戻ってくるセグエの設定
    }



}
