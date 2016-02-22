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

    
   
    
    //DBの名前
    let ENTITY_NAME = "Data"
    
    //txt1
    let ITEM_NAME1 = "content"
    //txt2
    let ITEM_NAME2 = "title"
    //txt3
    let ITEM_NAME3 = "image"
    
    //dateはString型ではない
    let ITEM_NAME4 = "date"
 
    @IBOutlet weak var myContent: UITextView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myDate: UITextField!
    @IBOutlet weak var myTitle: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //データを読み込む
//        myContent.text = readData()

        readData()
    }
    
    // データ登録/更新
    func writeData(txtData: String) -> Bool{
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
                let txt3 = obj.valueForKey(ITEM_NAME3) as! String
                
                obj.setValue(txtData, forKey: ITEM_NAME)
                print("UPDATE \(txt) TO \(txtData)")
                appDelegate.saveContext()
                ret = true
                
            }else{
                // 見つからなかったら新規登録
                let entity: NSEntityDescription! = NSEntityDescription.entityForName(ENTITY_NAME, inManagedObjectContext: context)
                let obj = Data(entity: entity, insertIntoManagedObjectContext: context)
                obj.setValue(txtData, forKey: ITEM_NAME)
                print("INSERT \(txtData)")
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
                let txt = obj.valueForKey(ITEM_NAME) as! String
                print("READ:\(txt)")
                ret = txt
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
                let txt = obj.valueForKey(ITEM_NAME) as! String
                print("DELETE \(txt)")
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
        writeData(myContent.text!)
        writeData(myDate.text!)
        writeData(myTitle.text!)
        
        //写真あとでエラーがでる
//        writeData(myImage.image!)
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

