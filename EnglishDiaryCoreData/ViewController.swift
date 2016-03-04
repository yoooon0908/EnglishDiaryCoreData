//
//  ViewController.swift
//  EnglishDiaryCoreData
//
//  Created by 三浦宏予 on 2016/02/22.
//  Copyright © 2016年 Hiroyo Miura. All rights reserved.
//
import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    
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
    
    //dateはString型ではない
    let ITEM_NAME3 = "date"

    //txt3
    let ITEM_NAME4 = "image"

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //データを読み込む
        //        myContent.text = readData()
        
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
            if (results.count > 0 ) {
                // 検索して見つかったらアップデートする
                let obj = results[0] as! NSManagedObject
                
                
            
                
                let txt1 = obj.valueForKey(ITEM_NAME1) as! String
                let txt2 = obj.valueForKey(ITEM_NAME2) as! String
                let txt3 = obj.valueForKey(ITEM_NAME3) as! NSDate
                let txt4 = obj.valueForKey(ITEM_NAME4) as! String

                
                
                
//                obj.setValue(txtData, forKey: ITEM_NAME1)
//                obj.setValue(txtData, fonrKey: ITEM_NAME2)
//                obj.setValue(txtData, forKey: ITEM_NAME3)
                
               

                
                obj.setValue(myContent.text, forKey: "content")
                obj.setValue(myTitle.text, forKey: "title")
                obj.setValue(myDate.text, forKey: "date")
                
                
                let df = NSDateFormatter()
                df.dateFormat = "yyy/MM/dd"
                myDate.text = df.dateFormat
                
                
                print("UPDATE \(txt1) TO \(myContent.text)")
                print("UPDATE \(txt2) TO \(myTitle.text)")
                print("UPDATE \(txt3) TO \(myDate.text)")
                print("UPDATE \(txt4) TO \(myDate.text)")
                
                
                
                appDelegate.saveContext()
                ret = true
                
            }else{
                // 見つからなかったら新規登録
                let entity: NSEntityDescription! = NSEntityDescription.entityForName(ENTITY_NAME, inManagedObjectContext: context)
                let obj = Data(entity: entity, insertIntoManagedObjectContext: context)
//                obj.setValue(txtData, forKey: ITEM_NAME1)
//                obj.setValue(txtData, forKey: ITEM_NAME2)
//                obj.setValue(txtData, forKey: ITEM_NAME3)
                
                obj.setValue(myContent.text, forKey: "content")
                obj.setValue(myTitle.text, forKey: "title")
                obj.setValue(myDate.text, forKey: "date")
                obj.setValue(myImage.image, forKey: "image")
                
                print("INSERT \(myContent.text)")
                print("INSERT \(myTitle.text)")
                print("INSERT \(myDate.text)")
                print("INSERT \(myImage.image)")
                
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
                let txt3 = obj.valueForKey(ITEM_NAME3) as! String
                let txt4 = obj.valueForKey(ITEM_NAME4) as! String
                
                print("READ:\(txt1)")
                print("READ:\(txt2)")
                print("READ:\(txt3)")
                print("READ:\(txt4)")
                
                ret = txt1
                ret = txt2
                ret = txt3
                ret = txt4
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
                
                print("DELETE \(txt1)")
                print("DELETE \(txt2)")
                print("DELETE \(txt3)")
                print("DELETE \(txt4)")
                
                
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
        
        writeData()
        
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
    
}