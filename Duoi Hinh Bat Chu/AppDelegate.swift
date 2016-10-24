//
//  AppDelegate.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/24/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var commonData:SettingDTO!
    var window: UIWindow?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        copyDatabase()
        GADMobileAds.configureWithApplicationID("ca-app-pub-8123415297019784~8909888406");

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func copyDatabase(){
        
        let fileManager = NSFileManager.defaultManager()
        
        let dbPath = getDBPath()
        let success = fileManager.fileExistsAtPath(dbPath)
        
        if(!success) {
            if let defaultDBPath = NSBundle.mainBundle().pathForResource("database", ofType: "sqlite"){
                
                //                var error:NSError?
                do{
                    try fileManager.copyItemAtPath(defaultDBPath, toPath: dbPath);
                    
                }catch {
                    print("Failed to create writable database file with message")
                    
                }
                print(defaultDBPath)
                if (!success){
                }
            }else{
                print("Cannot Find File In NSBundle")
            }
        }else{
            print("File Already Exist At:\(dbPath)")
        }
    }
    
    
    func getDBPath()->String
    {
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDir = paths[0]
        let databasePath = documentsDir.stringByAppendingString("/database.sqlite")
        return databasePath;
    }
    //ham luu cau hoi hien tai
    func saveLevelFolk(id:Int){
        let defaults:NSUserDefaults=NSUserDefaults.standardUserDefaults()
        defaults.synchronize()

        defaults.setInteger(id, forKey: "levelFolk")
    }
    func getCurrentLevelFolk()->Int{
        let defaults:NSUserDefaults=NSUserDefaults.standardUserDefaults()
        if (defaults.integerForKey("levelFolk") != 0){
            return defaults.integerForKey("levelFolk")
        }else{
            return 0
        }
    }
    //ham luu cau hoi hien tai
    func saveLevelTroll(id:Int){
        let defaults:NSUserDefaults=NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
        
        defaults.setInteger(id, forKey: "levelTroll")
    }
    func getCurrentLevelTroll()->Int{
        let defaults:NSUserDefaults=NSUserDefaults.standardUserDefaults()
        if (defaults.integerForKey("levelTroll") != 0){
            return defaults.integerForKey("levelTroll")
        }else{
            return 0
        }
    }
    //ham luu ruby
    func saveRuby(id:Int){
        let defaults:NSUserDefaults=NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
        
        defaults.setInteger(id, forKey: "ruby")
    }

    //ham get ruby
    func getRuby()->Int{
        let defaults:NSUserDefaults=NSUserDefaults.standardUserDefaults()
        if (defaults.integerForKey("ruby") != 0){
            return defaults.integerForKey("ruby")
        }else{
            return 300
        }
    }
    class getInstance
    {
        static var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    }


}

