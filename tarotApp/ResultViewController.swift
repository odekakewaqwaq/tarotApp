//
//  ResultViewController.swift
//  tarotApp
//
//  Created by 永井 伸枝 on 2016/05/26.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var numberImageView: UIImageView!
    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var resultTextView: UITextView!
    
    @IBAction func back(sender: AnyObject) {
    }
    @IBAction func forward(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
