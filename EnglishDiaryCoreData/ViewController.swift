//
//  ViewController.swift
//  EnglishDiaryCoreData
//
//  Created by 三浦宏予 on 2016/02/22.
//  Copyright © 2016年 Hiroyo Miura. All rights reserved.
//
import UIKit
import CoreData

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var myContent: UITextView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myDate: UITextField!
    @IBOutlet weak var myTitle: UITextField!
    
    
    //DBの名前
    let ENTITY_NAME = "Data"
    //txt1
    let ITEM_NAME1 = "content"
    //txt2
    let ITEM_NAME2 = "title"
    //txt3
    let ITEM_NAME3 = "date"
    //txt4
    let ITEM_NAME4 = "image"
    
    var assetURL = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //データを読み込む
        //        myContent.text = readData()
        
        //print(NSBundle.mainBundle())
        
//        //ファイルの場所を探せる↓
        //#if DEBUG
//            print("----------------------------------");
//            print("[DEBUG]");
//            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
//            print(documentsPath)
//            print("----------------------------------");
//        //#endif
        
        
        readData()
    }
    
    // データ登録/更新
    func writeData() -> Bool{
        var ret = false
        
        let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: ENTITY_NAME)
        request.returnsObjectsAsFaults = false
        
        do {
            let results: Array = try context.executeFetchRequest(request)
            
            let df = NSDateFormatter()
            df.dateFormat = "yyyy/MM/dd"

            if (results.count > 0 ) {
                // 検索して見つかったらアップデートする
                let obj = results[0] as! NSManagedObject
                
                
                let txt1 = obj.valueForKey(ITEM_NAME1) as! String
                let txt2 = obj.valueForKey(ITEM_NAME2) as! String
                let txt3 = obj.valueForKey(ITEM_NAME3) as! NSDate
                let txt4 = obj.valueForKey(ITEM_NAME4) as! String
                
                
                obj.setValue(myContent.text, forKey: "content")
                obj.setValue(myTitle.text, forKey: "title")
                obj.setValue(df.dateFromString(myDate.text!), forKey: "date")
                obj.setValue(myDate.text, forKey: "image")
                
                
                print("UPDATE CONTENT: \(txt1) TO \(myContent.text)")
                print("UPDATE TITLE: \(txt2) TO \(myTitle.text)")
                print("UPDATE DATE: \(txt3) TO \(myDate.text)")
                print("UPDATE IMAGE: \(txt4) TO \(myImage.image)")
                
                
                
                
                appDelegate.saveContext()
                ret = true
                
            }else{
                // 見つからなかったら新規登録
                let entity: NSEntityDescription! = NSEntityDescription.entityForName(ENTITY_NAME, inManagedObjectContext: context)
                let obj = Data(entity: entity, insertIntoManagedObjectContext: context)
                
                
                obj.setValue(myContent.text, forKey: "content")
                obj.setValue(myTitle.text, forKey: "title")
                obj.setValue(df.dateFromString(myDate.text!), forKey: "date")
                obj.setValue(assetURL, forKey: "image")
                
                
                print("INSERT CONTENT: \(myContent.text)")
                print("INSERT TITLE: \(myTitle.text)")
                print("INSERT DATE: \(myDate.text)")
                print("INSERT IMAGE: \(myImage.image)")
                
               
                
                do {
                    try context.save()
                } catch let error as NSError {
                    // エラー処理
                    print("INSERT ERROR:\(error.localizedDescription)")
                }
                ret = true
            }
        } catch let error as NSError {
            // エラー処理
            print("FETCH ERROR:\(error.localizedDescription)")
        }
        return ret
    }
    
    // データ読み込み
    func readData() -> String{
        var ret = ""
        
        let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: ENTITY_NAME)
        request.returnsObjectsAsFaults = false
        
        do {
            let results : Array = try context.executeFetchRequest(request)
            if (results.count > 0 ) {
                // 見つかったら読み込み
                let obj = results[0] as! NSManagedObject
                let txt1 = obj.valueForKey(ITEM_NAME1) as! String
                let txt2 = obj.valueForKey(ITEM_NAME2) as! String
                let txt3 = obj.valueForKey(ITEM_NAME3) as! NSDate
                let txt4 = obj.valueForKey(ITEM_NAME4) as! String
                
                print("READ CONTENT:\(txt1)")
                print("READ TITLE:\(txt2)")
                print("READ DATE:\(txt3)")
                print("READ IMAGE:\(txt4)")
                
               
//                ret = txt1
//                ret = txt2
//                ret = txt3
//                ret = txt4
                
            }
        } catch let error as NSError {
            // エラー処理
            print("READ ERROR:\(error.localizedDescription)")
        }
        return ret
    }
    
    // データ削除
    func deleteData() -> Bool {
        var ret = false
        
        let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: ENTITY_NAME)
        request.returnsObjectsAsFaults = false
        
        do {
            let results : Array = try context.executeFetchRequest(request)
            if (results.count > 0 ) {
                // 見つかったら削除
                let obj = results[0] as! NSManagedObject
                let txt1 = obj.valueForKey(ITEM_NAME1) as! String
                let txt2 = obj.valueForKey(ITEM_NAME2) as! String
                let txt3 = obj.valueForKey(ITEM_NAME3) as! NSDate
                let txt4 = obj.valueForKey(ITEM_NAME4) as! String
                
                print("DELETE CONTENT \(txt1)")
                print("DELETE TITLE \(txt2)")
                print("DELETE DATE \(txt3)")
                print("DELETE IMAGE \(txt4)")
                
                               
                context.deleteObject(obj)
                appDelegate.saveContext()
            }
            ret = true
        } catch let error as NSError {
            // エラー処理
            print("FETCH ERROR:\(error.localizedDescription)")
        }
        return ret
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func tapSave(sender: UIButton) {
        
//        writeData(myContent.text!)
//        writeData(myDate.text!)
//        writeData(myTitle.text!)
        
        //writeData()
        
        let df = NSDateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        


        
        //アラートを出す
        if df.dateFromString(myDate.text!) == ""  {
            
            let alertController = UIAlertController(title: "Please!!", message: "すべての項目を入力してください。", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
            
        }else if myImage.image == "" {
            
                let alertController = UIAlertController(title: "Please!!", message: "すべての項目を入力してください。", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                presentViewController(alertController, animated: true, completion: nil)
            
        }else if myTitle.text == "" {
            
                let alertController = UIAlertController(title: "Please!!", message: "すべての項目を入力してください。", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                presentViewController(alertController, animated: true, completion: nil)

        }else if myContent.text == "" {
            
                let alertController = UIAlertController(title: "Please!!", message: "すべての項目を入力してください。", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                presentViewController(alertController, animated: true, completion: nil)

        }else{
            
            var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("welcome")
            self.presentViewController(targetView as! UIViewController, animated: true, completion: nil)
        
        }
    }
    
    
    //データを削除する
    @IBAction func tapDelete(sender: UIButton) {
        myContent.text = nil
        myDate.text = nil
        myImage.image = nil
        myTitle.text = nil
        
        deleteData()
    }
    
    
    //データ削除をのちにスライドすることで削除するようにつくる
    @IBAction func TapGesture(sender: UITapGestureRecognizer) {
    }
    
    @IBAction func tapImageView(sender: UIButton) {
       
            // フォトライブラリが使用可能か？
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                
                // フォトライブラリの選択画面を表示
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.presentViewController(picker, animated: true, completion: nil)
           
            }
        }
        
        // 写真選択時に呼ばれる
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
            // 選択した画像を取得
            if info[UIImagePickerControllerOriginalImage] != nil {
                if let photo:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    myImage.image = photo
                    assetURL = (info[UIImagePickerControllerReferenceURL]?.description)!
                }
            }
            
            picker.dismissViewControllerAnimated(true, completion: nil)
            
        }
    
}