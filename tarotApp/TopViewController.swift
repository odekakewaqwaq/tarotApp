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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initCardArray(){
        //0が22個の行列つくる
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
        let date_a = calendar.dateWithEra(1, year: 1986, month: 8, day: 20, hour: 2, minute: 27, second: 0, nanosecond: 0)!
        let dic = ["lastTimeDrewAt" : date_a]
        defaults.registerDefaults(dic)
        defaults.synchronize()
    }
    
    func checkLifePoint(){
        let lifePoint = defaults.integerForKey("lifePoint")
        print("LifePoint is \(lifePoint)")
    }
    
    func drawAnnotation(){
        let date_b = defaults.objectForKey("lastTimeDrewAt") as? NSDate
        print(date_b!)
    }
    
    @IBAction func backToTop(segue: UIStoryboardSegue) {//戻ってくるセグエの設定
    }



}
