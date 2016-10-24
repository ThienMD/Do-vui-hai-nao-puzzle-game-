//
//  MainViewController.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/24/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit
import GoogleMobileAds
class MainViewController: BaseViewController ,GADRewardBasedVideoAdDelegate{
    var gameType:Bool=false
    var setting:SettingDTO!
    var interstitial: GADInterstitial!
    var button:UIButton!
    @IBOutlet var btSound: UIButton!
    
    @IBOutlet var bannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSetting()
        backGroundPlay()
        button=UIButton(frame: CGRectMake(100, 100, 120, 80))
        button.setTitle("Test animation", forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("animateButton"), forControlEvents: UIControlEvents.TouchUpInside)
        
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.view.addSubview(button)
//        loadBanner()
//        for family: String in UIFont.familyNames()
//        {
//            print("\(family)")
//            for names: String in UIFont.fontNamesForFamilyName(family)
//            {
//                print("== \(names)")
//            }/Users/admin/Documents/IOS project/Duoi Hinh Bat Chu/Duoi Hinh Bat Chu/dola_icon.png
//        }
    }
    func animateButton(){
        self.button.slideInFromLeft()
        button.setTitle("demo thien", forState: UIControlState.Normal)
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.duration = 0.07
//        animation.repeatCount = 4
//        animation.autoreverses = true
//        animation.fromValue = NSValue(CGPoint: CGPointMake(button.center.x - 10, button.center.y))
//        animation.toValue = NSValue(CGPoint: CGPointMake(button.center.x + 10, button.center.y))
//        button.layer.addAnimation(animation, forKey: "position")
    }
    
    private func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-6796657973609537/5555494803")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
//        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b" ]
        interstitial.loadRequest(GADRequest())
    }
    private func rewardvideo() {
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        let request = GADRequest()
        // Requests test ads on test devices.
        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b" ]
        GADRewardBasedVideoAd.sharedInstance().loadRequest(request, withAdUnitID: "ca-app-pub-6796657973609537/7590631206")
    }
    
    func loadBanner(){
        bannerView.adUnitID = "ca-app-pub-6796657973609537/6845914801"
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())
//        request.testDevices = @[ kGADSimulatorID ]
    }
    @IBAction func earnRubyClick(sender: AnyObject) {
        
        createAndLoadInterstitial()
        
//        SweetAlert().showAlert("Nhận Ruby Miễn Phí", subTitle: "Click Coi video quảng cáo để nhận ngay 50 ruby", style: AlertStyle.CustomImag(imageFile: "dola_icon.png") ,buttonTitle:"    Huỷ   ", buttonColor:UIColor.orangeColor() , otherButtonTitle:  "Coi Ngay", otherButtonColor: UIColor.greenColor()){ (isOtherButton) -> Void in
//            if isOtherButton == true {
//                self.createAndLoadInterstitial()
//            }
//            else {
//                
//            }
//        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func gotoPlayGame(){
        
        self.performSegueWithIdentifier("PlayGame", sender: nil)
        
    }
    
    func updateTable(){
        let table=SettingTable()
        table.updateTable(setting)
    }
    
    private  func getSetting(){
    
        let table=SettingTable()
        setting=table.getAll()
        getAppDelegate().commonData=setting
        changeSoundBackground(setting.sound)
        
        
    }
    @IBAction func btShareClick(sender: AnyObject) {
        
        let textToShare = "Cùng giải các câu đố hại não tại!"
        
        if let myWebsite = NSURL(string: "itms-apps://itunes.apple.com/app/id959379869") {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            if #available(iOS 8.0, *) {
                activityVC.popoverPresentationController?.sourceView = sender as? UIView
            } else {
                // Fallback on earlier versions
            }
            self.presentViewController(activityVC, animated: true, completion: nil)
        }

        
        
        
    }
    @IBAction func btSoundClick(sender: AnyObject) {
        popSoundPlay()
      setting.sound = !setting.sound
        getAppDelegate().commonData=setting
        self.updateTable()
        changeSoundBackground(setting.sound)
    }
    @IBAction func btLikeClick(sender: AnyObject) {
        popSoundPlay()

        UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id959379869")!)

            }

    @IBAction func btTrollClick(sender: AnyObject) {
        popSoundPlay()

        gameType=false;
        gotoPlayGame()
    }
    @IBAction func btDanGianClick(sender: AnyObject) {
        popSoundPlay()

        gameType=true;
        
        gotoPlayGame()
    }
    
    private func changeSoundBackground(check:Bool){
        let highLight="btn_sound" 
        let normal="btn_sound_off"
        if check{
            backGroundPlay()
            btSound.setImage(UIImage(named: highLight), forState: UIControlState.Normal)

        }else{
            btSound.setImage(UIImage(named: normal), forState: UIControlState.Normal)
            stopSound()

        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlayGame" {
            let vc = segue.destinationViewController as! PlayGameViewController
            if gameType{
                vc.actionEvent=PlayGameViewController.enumAction.Folk
                
            }else{
                vc.actionEvent=PlayGameViewController.enumAction.Troll
                
            }
        }
    }
    func loadReward(){
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())
        
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
