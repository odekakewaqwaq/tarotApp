//
//  CaptionViewController.swift
//  tarotApp
//
//  Created by 永井 伸枝 on 2016/06/05.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit

class CaptionViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var cardNum = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("cardNum is \(cardNum)")
        var str: String = "face"+String(cardNum)
        print("Str=\(str)")
        label.text = str
        let image =  UIImage(named: str)
        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
