//
//  SecondViewController.swift
//  EnglishDiaryCoreData
//
//  Created by 三浦宏予 on 2016/03/07.
//  Copyright © 2016年 Hiroyo Miura. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate


    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myDate: UILabel!
    @IBOutlet weak var myTitle: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        appDelegate.
        
       
        //myImageView.image = appDelegate.myImage
        myDate.text = appDelegate.myDate
        myTitle.text = appDelegate.myTitle
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
