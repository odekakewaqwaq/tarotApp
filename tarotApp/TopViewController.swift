//
//  TopViewController.swift
//  tarotApp
//
//  Created by 永井 伸枝 on 2016/06/10.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initCardArray()
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
        let defaults = NSUserDefaults.standardUserDefaults()
        let dic = ["cardArray": cardArray]
        defaults.registerDefaults(dic)
        defaults.synchronize()
        
        var testArray = defaults.arrayForKey("cardArray")
        print("FirstViewArray\(testArray)")
    }
    @IBAction func backToTop(segue: UIStoryboardSegue) {//戻ってくるセグエの設定
    }



}
