//
//  ViewController.swift
//  NBCU_tvOS_HLS_fmp4_Player_AVFound
//
//  Created by Chris Seeger on 11/12/22.
//  Copyright © 2022 NBCUniversal. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController, AVAudioPlayerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // register settings bundle with user defaults
        registerSettingsBundle()
        
        loadDefaults()
        setButtonLables()
        
        
    // Watch for application moving to foreground so button labels can be updated
        let notificationCenterForeground = NotificationCenter.default
        notificationCenterForeground.addObserver(self, selector: #selector(appMovedToForegroundUpdateButtonLabels), name: UIApplication.willEnterForegroundNotification, object: nil)
        

        
    }
    
    
    //Attach button labels to variables
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    
    
    
    // Update Button A,B,C Labels when app moves to foreground
    @objc func appMovedToForegroundUpdateButtonLabels() {
        print("App moved to ForeGround!")
        
        setButtonLables()
        
    }
    
    
    
    // Label all buttons via root settings bundle
    func setButtonLables() {
        
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        
        
        // Update button text from root preferences bundle
        let aButtonLabelText = userDefaults.string(forKey: "a_button_label")
        aButton.setTitle(aButtonLabelText, for: .normal)
        
        let bButtonLabelText = userDefaults.string(forKey: "b_button_label")
        bButton.setTitle(bButtonLabelText, for: .normal)
        
        let cButtonLabelText = userDefaults.string(forKey: "c_button_label")
        cButton.setTitle(cButtonLabelText, for: .normal)
        
        registerSettingsBundle()
        loadDefaults()
        
    }
    
    
    
    @IBAction func butGoToSettingsTapped(_ sender: Any) {
        let alertController = UIAlertController (title: "Settings", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
            
        }
        
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func btnUHDVideoPlayerTapped(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        let streamURL = userDefaults.string(forKey: "a_url")
        
        guard let VideoURL = URL(string: streamURL!) else {
            debugPrint ("URL not found")
            return
        }
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
        
         // Update button text from root preferences bundle
        let aButtonLabelText = userDefaults.string(forKey: "a_button_label")
        aButton.setTitle(aButtonLabelText, for: .normal)
        
    }
    
    @IBAction func btn1080PVideoPlayTapped(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        let streamURL = userDefaults.string(forKey: "b_url")
        
        guard let VideoURL = URL(string: streamURL!) else {
            debugPrint ("URL not found")
            return
        }
        
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
        
         // Update button text from root preferences bundle
        let bButtonLabelText = userDefaults.string(forKey: "b_button_label")
        bButton.setTitle(bButtonLabelText, for: .normal)
        
    }
    
    
    @IBAction func btn720VideoPlayerTapped(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        let streamURL = userDefaults.string(forKey: "c_url")
        
        guard let VideoURL = URL(string: streamURL!) else {
            debugPrint ("URL not found")
            return
        }
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
        
        // Update button text from root preferences bundle
        let cButtonLabelText = userDefaults.string(forKey: "c_button_label")
        cButton.setTitle(cButtonLabelText, for: .normal)
        
        
    }
    
    
    @IBAction func btnAppleRefVideoPlayerTapped(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        let streamURL = userDefaults.string(forKey: "apple_ref_url")
        
        guard let VideoURL = URL(string: streamURL!) else {
            debugPrint ("URL not found")
            return
        }
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
    }
    
    @IBAction func butDolbyP5VideoPlayerTapped(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        let streamURL = userDefaults.string(forKey: "dolby_ref_url")
        
        guard let VideoURL = URL(string: streamURL!) else {
            debugPrint ("URL not found")
            return
        }
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
    }
    
    //created a string variable
    var name: String = ""
    
 
    @IBOutlet weak var CustomURLTextf: UITextField!
    
    @IBAction func btnCustomURLVideoPlayerTapped(_ sender: UIButton) {

        //getting input from Text Field
        name = CustomURLTextf.text!
        
        let VideoURL = name as String
        let player = AVPlayer(url: URL(fileURLWithPath: VideoURL))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
    }
    
    
// Set up Root Settings bundle and sync with user defaults
    
   // Register settings bundle
    func registerSettingsBundle(){
    let appDefaults = [String:AnyObject]()
    UserDefaults.standard.register(defaults: appDefaults)
    UserDefaults.standard.synchronize()
    }
    
    
    private func loadDefaults() {
        let userDefaults = UserDefaults.standard
        
        let pathStr = Bundle.main.bundlePath
        let settingsBundlePath = (pathStr as NSString).appendingPathComponent("Settings.bundle")
        let finalPath = (settingsBundlePath as NSString).appendingPathComponent("Root.plist")
        let settingsDict = NSDictionary(contentsOfFile: finalPath)
        guard let prefSpecifierArray = settingsDict?.object(forKey: "PreferenceSpecifiers") as? [[String: Any]] else {
            return
        }
        
        var defaults = [String: Any]()
        
        for prefItem in prefSpecifierArray {
            guard let key = prefItem["Key"] as? String else {
                continue
            }
            defaults[key] = prefItem["DefaultValue"]
        }
        userDefaults.register(defaults: defaults)
    }
    
 
    
    
    
    
}


