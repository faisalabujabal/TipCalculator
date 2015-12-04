//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Faisal Abu Jabal on 12/2/15.
//  Copyright © 2015 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    let defaultUserData = NSUserDefaults.standardUserDefaults();
    
    @IBOutlet weak var DefaultTipByPercentageField: UITextField!
    @IBOutlet weak var DefaultTipSliderMinimum: UITextField!
    @IBOutlet weak var DefaultTipSliderMaximum: UITextField!
    
    @IBOutlet weak var DefaultStarTextField: UITextField!
    @IBOutlet weak var OneStarDefaultPercentageTextField: UITextField!
    @IBOutlet weak var TwoStarsDefaultPercentageTextField: UITextField!
    @IBOutlet weak var ThreeStarsDefaultPercentageTextField: UITextField!
    @IBOutlet weak var FourStarsDefaultPercentageTextField: UITextField!
    @IBOutlet weak var FiveStarsDefaultPercentageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // declare some constants
        let starterTipByPercentage = 18
        let starterTipSliderMinimum = 5
        let starterTipSliderMaximum = 30
        let starterDefaultStar = 3
        let starterDefaultOneStarPercentage = 5
        let starterDefaultTwoStarsPercentage = 10
        let starterDefaultThreeStarsPercentage = 15
        let starterDefaultFourStarsPercentage = 20
        let starterDefaultFiveStarsPercentage = 30
        
        let defaultTip = defaultUserData.objectForKey("DefaultTipByPercentage") as! Double?
        if(defaultTip != nil){
            DefaultTipByPercentageField.text = String(Int(defaultTip!)) + "%"
            DefaultTipByPercentageField.placeholder = String(Int(defaultTip!)) + "%"
        } else {
            defaultUserData.setDouble(Double(starterTipByPercentage), forKey: "DefaultTipByPercentage")
        }
        
        let defaultMinimumTipSlider = defaultUserData.objectForKey("DefaultMinimumTipSlider") as! Double?
        if(defaultMinimumTipSlider != nil){
            DefaultTipSliderMinimum.text = String(Int(defaultMinimumTipSlider!)) + "%"
            DefaultTipSliderMinimum.placeholder = String(Int(defaultMinimumTipSlider!)) + "%"
        } else {
            defaultUserData.setDouble(Double(starterTipSliderMinimum), forKey: "DefaultMinimumTipSlider")
        }
        
        let defaultMaximumTipSlider = defaultUserData.objectForKey("DefaultMaximumTipSlider") as! Double?
        if(defaultMaximumTipSlider != nil){
            DefaultTipSliderMaximum.text = String(Int(defaultMaximumTipSlider!)) + "%"
            DefaultTipSliderMaximum.placeholder = String(Int(defaultMaximumTipSlider!)) + "%"
        } else {
            defaultUserData.setDouble(Double(starterTipSliderMaximum), forKey: "DefaultMaximumTipSlider")
        }
        
        let defaultStarRating = defaultUserData.objectForKey("DefaultStarRating") as! Int?
        if(defaultStarRating != nil){
            DefaultStarTextField.text = String(defaultStarRating!)
            DefaultStarTextField.placeholder = String(defaultStarRating!)
        } else {
            defaultUserData.setInteger(starterDefaultStar, forKey: "DefaultStarRating")
        }
        
        let defaultOneStarPercentage = defaultUserData.objectForKey("DefaultOneStarPercentage") as! Double?
        if(defaultOneStarPercentage != nil){
            OneStarDefaultPercentageTextField.text = String(Int(defaultOneStarPercentage!)) + "%"
            OneStarDefaultPercentageTextField.placeholder = String(Int(defaultOneStarPercentage!)) + "%"
        } else {
            defaultUserData.setDouble(Double(starterDefaultOneStarPercentage), forKey: "DefaultOneStarPercentage")
        }
        
        let defaultTwoStarsPercentage = defaultUserData.objectForKey("DefaultTwoStarsPercentage") as! Double?
        if(defaultTwoStarsPercentage != nil){
            TwoStarsDefaultPercentageTextField.text = String(Int(defaultTwoStarsPercentage!)) + "%"
            TwoStarsDefaultPercentageTextField.placeholder = String(Int(defaultTwoStarsPercentage!)) + "%"
        } else {
            defaultUserData.setDouble(Double(starterDefaultTwoStarsPercentage), forKey: "DefaultTwoStarsPercentage")
        }
        
        let defaultThreeStarsPercentage = defaultUserData.objectForKey("DefaultThreeStarsPercentage") as! Double?
        if(defaultThreeStarsPercentage != nil){
            ThreeStarsDefaultPercentageTextField.text = String(Int(defaultThreeStarsPercentage!)) + "%"
            ThreeStarsDefaultPercentageTextField.placeholder = String(Int(defaultThreeStarsPercentage!)) + "%"
        } else {
            defaultUserData.setDouble(Double(starterDefaultThreeStarsPercentage), forKey: "DefaultThreeStarsPercentage")
        }
        
        let defaultFourStarsPercentage = defaultUserData.objectForKey("DefaultFourStarsPercentage") as! Double?
        if(defaultFourStarsPercentage != nil){
            FourStarsDefaultPercentageTextField.text = String(Int(defaultFourStarsPercentage!)) + "%"
            FourStarsDefaultPercentageTextField.placeholder = String(Int(defaultFourStarsPercentage!)) + "%"
        } else {
            defaultUserData.setDouble(Double(starterDefaultFourStarsPercentage), forKey: "DefaultFourStarsPercentage")
        }
        
        let defaultFiveStarsPercentage = defaultUserData.objectForKey("DefaultFiveStarsPercentage") as! Double?
        if(defaultFiveStarsPercentage != nil){
            FiveStarsDefaultPercentageTextField.text = String(Int(defaultFiveStarsPercentage!)) + "%"
            FiveStarsDefaultPercentageTextField.placeholder = String(Int(defaultFiveStarsPercentage!)) + "%"
        } else {
            defaultUserData.setDouble(Double(starterDefaultFiveStarsPercentage), forKey: "DefaultFiveStarsPercentage")
        }
    }
    
    @IBAction func AfterEditingDefaultTipTextField(sender: AnyObject) {
        if(DefaultTipByPercentageField.text != nil){
            let currentPercentageDouble = getPercentageFromText(DefaultTipByPercentageField.text)
            if(currentPercentageDouble != nil){
                // first I need to save the field to the defaultUserData
                defaultUserData.setDouble(currentPercentageDouble!, forKey: "DefaultTipByPercentage")
                defaultUserData.synchronize()
            }
        }
        DefaultTipByPercentageField.text = String(Int(defaultUserData.doubleForKey("DefaultTipByPercentage"))) + "%"
        DefaultTipByPercentageField.placeholder = String(Int(defaultUserData.doubleForKey("DefaultTipByPercentage"))) + "%"
    }
    
    
    @IBAction func AfterEditingMinimumTipSlider(sender: AnyObject) {
        if(DefaultTipSliderMinimum.text != nil){
            let currentMinimumPercentage = getPercentageFromText(DefaultTipSliderMinimum.text)
            let currentMaximumPercentage = getPercentageFromText(DefaultTipSliderMaximum.text)
            if(currentMinimumPercentage != nil && currentMinimumPercentage < currentMaximumPercentage){
                // first I need to save the field to the defaultUserData
                defaultUserData.setDouble(currentMinimumPercentage!, forKey: "DefaultMinimumTipSlider")
                defaultUserData.synchronize()
            }
        }
        DefaultTipSliderMinimum.text = String(Int(defaultUserData.doubleForKey("DefaultMinimumTipSlider"))) + "%"
        DefaultTipSliderMinimum.placeholder = String(Int(defaultUserData.doubleForKey("DefaultMinimumTipSlider"))) + "%"
    }
    
    
    @IBAction func AfterEditingMaximumTipSlider(sender: AnyObject) {
        if(DefaultTipSliderMaximum.text != nil){
            let currentMaximumPercentage = getPercentageFromText(DefaultTipSliderMaximum.text)
            let currentMinimumPercentage = getPercentageFromText(DefaultTipSliderMinimum.text)
            if(currentMaximumPercentage != nil && currentMaximumPercentage > currentMinimumPercentage){
                // first I need to save the field to the defaultUserData
                defaultUserData.setDouble(currentMaximumPercentage!, forKey: "DefaultMaximumTipSlider")
                defaultUserData.synchronize()
            }
        }
        DefaultTipSliderMaximum.text = String(Int(defaultUserData.doubleForKey("DefaultMaximumTipSlider"))) + "%"
        DefaultTipSliderMaximum.placeholder = String(Int(defaultUserData.doubleForKey("DefaultMaximumTipSlider"))) + "%"
    }
    
    
    @IBAction func AfterEditingDefualtStarTextField(sender: UITextField) {
        if(DefaultStarTextField.text != nil){
            if(Int(DefaultStarTextField.text!) > 0 && Int(DefaultStarTextField.text!) < 6){
                defaultUserData.setInteger(Int(DefaultStarTextField.text!)!, forKey: "DefaultStarRating")
                defaultUserData.synchronize()
            }
        }
        DefaultStarTextField.text = String(Int(defaultUserData.integerForKey("DefaultStarRating")))
        DefaultStarTextField.placeholder = String(Int(defaultUserData.integerForKey("DefaultStarRating")))
    }
    
    
    @IBAction func AfterEditingOneStarPercentageTextField(sender: AnyObject) {
        if(OneStarDefaultPercentageTextField.text != nil){
            if(Int(OneStarDefaultPercentageTextField.text!) >= 0) {
                defaultUserData.setInteger(Int(OneStarDefaultPercentageTextField.text!)!, forKey: "DefaultOneStarPercentage")
                defaultUserData.synchronize()
            }
        }
        OneStarDefaultPercentageTextField.text = String(Int(defaultUserData.integerForKey("DefaultOneStarPercentage"))) + "%"
        OneStarDefaultPercentageTextField.placeholder = String(Int(defaultUserData.integerForKey("DefaultOneStarPercentage"))) + "%"
    }
    
    
    @IBAction func AfterEditingTwoStarsTextField(sender: AnyObject) {
        if(TwoStarsDefaultPercentageTextField.text != nil){
            if(Int(TwoStarsDefaultPercentageTextField.text!) >= 0) {
                defaultUserData.setInteger(Int(TwoStarsDefaultPercentageTextField.text!)!, forKey: "DefaultTwoStarsPercentage")
                defaultUserData.synchronize()
            }
        }
        TwoStarsDefaultPercentageTextField.text = String(Int(defaultUserData.integerForKey("DefaultTwoStarsPercentage"))) + "%"
        TwoStarsDefaultPercentageTextField.placeholder = String(Int(defaultUserData.integerForKey("DefaultTwoStarsPercentage"))) + "%"
    }
    
    
    @IBAction func AfterEditingThreeStarsTextField(sender: AnyObject) {
        if(ThreeStarsDefaultPercentageTextField.text != nil){
            if(Int(ThreeStarsDefaultPercentageTextField.text!) >= 0) {
                defaultUserData.setInteger(Int(ThreeStarsDefaultPercentageTextField.text!)!, forKey: "DefaultThreeStarsPercentage")
                defaultUserData.synchronize()
            }
        }
        ThreeStarsDefaultPercentageTextField.text = String(Int(defaultUserData.integerForKey("DefaultThreeStarsPercentage"))) + "%"
        ThreeStarsDefaultPercentageTextField.placeholder = String(Int(defaultUserData.integerForKey("DefaultThreeStarsPercentage"))) + "%"
    }
    
    
    @IBAction func AfterEditingFourStarsTextField(sender: AnyObject) {
        if(FourStarsDefaultPercentageTextField.text != nil){
            if(Int(FourStarsDefaultPercentageTextField.text!) >= 0) {
                defaultUserData.setInteger(Int(FourStarsDefaultPercentageTextField.text!)!, forKey: "DefaultFourStarsPercentage")
                defaultUserData.synchronize()
            }
        }
        FourStarsDefaultPercentageTextField.text = String(Int(defaultUserData.integerForKey("DefaultFourStarsPercentage"))) + "%"
        FourStarsDefaultPercentageTextField.placeholder = String(Int(defaultUserData.integerForKey("DefaultFourStarsPercentage"))) + "%"
    }
    
    
    @IBAction func AfterEditingFiveStarsTextField(sender: AnyObject) {
        if(FiveStarsDefaultPercentageTextField.text != nil){
            if(Int(FiveStarsDefaultPercentageTextField.text!) >= 0) {
                defaultUserData.setInteger(Int(FiveStarsDefaultPercentageTextField.text!)!, forKey: "DefaultFiveStarsPercentage")
                defaultUserData.synchronize()
            }
        }
        FiveStarsDefaultPercentageTextField.text = String(Int(defaultUserData.integerForKey("DefaultFiveStarsPercentage"))) + "%"
        FiveStarsDefaultPercentageTextField.placeholder = String(Int(defaultUserData.integerForKey("DefaultFiveStarsPercentage"))) + "%"
    }
    
    // when tap on the screen dismiss the keyboard
    @IBAction func OnTap(sender: AnyObject) {
        tableView.endEditing(true)
    }
    
    
    @IBAction func SwipingRight(sender: AnyObject) {
        tabBarController?.selectedIndex = 1
    }
    
    // this function gets the current percentage rate as a double
    func getPercentageFromText(currentTextField: String?) -> Double? {
        if(currentTextField != nil){
            var retPercentageRate = ""
            for char in currentTextField!.characters {
                if(char != "%"){
                    retPercentageRate += String(char)
                }
            }
            if(retPercentageRate != ""){
                return (Double(retPercentageRate)!)
            }
        }
        return nil
    }
}
