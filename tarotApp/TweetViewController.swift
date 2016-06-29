//
//  TweetViewController.swift
//  tarotApp
//
//  Created by 永井 伸枝 on 2016/06/10.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit
import Accounts
import Social

class TweetViewController: UIViewController {
    let defaults = NSUserDefaults.standardUserDefaults()
    var myComposeView : SLComposeViewController!
    
    @IBAction func tweetButton(sender: AnyObject) {
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        myComposeView.setInitialText("ソワカちゃん、いいよね…")
        myComposeView.completionHandler = { (result:SLComposeViewControllerResult) -> Void in
            switch result {
            case SLComposeViewControllerResult.Done :
                print ("成功")
                var life = self.defaults.integerForKey("lifePoint")
                life += 1
                self.defaults.setInteger(life, forKey: "lifePoint")
                self.defaults.synchronize()
                print("Life is \(self.defaults.integerForKey("lifePoint"))")
            case SLComposeViewControllerResult.Cancelled :
                print ("キャンセル")
            }
        }
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
