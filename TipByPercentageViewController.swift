//
//  TipByPercentageViewController.swift
//  TipCalculator
//
//  Created by Faisal Abu Jabal on 12/1/15.
//  Copyright © 2015 Faisal Abu Jabal. All rights reserved.
//

import UIKit

extension Double {
    var asLocaleCurrency:String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(self)!
    }
}

class TipByPercentageViewController: UIViewController {
    
    var passedBillAmount: String? = nil
    
    @IBOutlet weak var BillAmountValue: UITextField!
    @IBOutlet weak var PercentageAmountValue: UITextField!
    @IBOutlet weak var satisfactoryEmoji: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var recieptTipAmountValue: UILabel!
    @IBOutlet weak var recieptBillAmountValue: UILabel!
    @IBOutlet weak var recieptTotalAmountValue: UILabel!
    @IBOutlet weak var recieptSplitterStepper: UIStepper!
    @IBOutlet weak var recieptTipAmountLabel: UILabel!
    @IBOutlet weak var SwipeDownToDismissLabel: UIView!
    @IBOutlet weak var SwipeDownToDismissImage: UIImageView!
    
    
    let defaultUserData = NSUserDefaults.standardUserDefaults();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the bill amount value text field to become
        // first responder
//        SwipeDownToDismissImage.alpha = 0
//        SwipeDownToDismissLabel.alpha = 0
        BillAmountValue.becomeFirstResponder()
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        SwipeDownToDismissImage.alpha = 0
        SwipeDownToDismissLabel.alpha = 0
        // BillAmountValue.becomeFirstResponder()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        if(passedBillAmount != nil){
            BillAmountValue.text = passedBillAmount
            BillAmountValue.placeholder = passedBillAmount
        }

        let defaultTip = defaultUserData.objectForKey("DefaultTipByPercentage") as! Double?
        if(defaultTip == nil){
            setCurrentPercentage(18)
        } else {
            setCurrentPercentage(defaultTip!)
        }
        
        updateReceipt()
        
        let minimumSliderTip = defaultUserData.objectForKey("DefaultMinimumTipSlider") as! Double?
        if(minimumSliderTip == nil){
            tipPercentageSlider.minimumValue = 5
        } else {
            tipPercentageSlider.minimumValue = Float(minimumSliderTip!)
        }
        
        let maximumSliderTip = defaultUserData.objectForKey("DefaultMaximumTipSlider") as! Double?
        if(maximumSliderTip == nil){
            tipPercentageSlider.maximumValue = 30
        } else {
            tipPercentageSlider.maximumValue = Float(maximumSliderTip!)
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        SwipeDownToDismissLabel.alpha = 1
        SwipeDownToDismissImage.alpha = 1
    }
    
    func keyboardWillHide(notification: NSNotification){
        SwipeDownToDismissImage.alpha = 0
        SwipeDownToDismissLabel.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // this function is called when the user taps on the main
    // container
    @IBAction func onTapMain(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    @IBAction func SwipingLeft(sender: AnyObject) {
        // tabBarController?.selectedIndex = 1
        let selectedIndex = 1
        UIView.transitionFromView(self.view,
            toView: tabBarController!.viewControllers![selectedIndex].view,
            duration: 0.5,
            options: UIViewAnimationOptions.TransitionFlipFromRight,
            completion: {
                finished in
                if finished {
                    self.tabBarController!.selectedIndex = selectedIndex
                }
        })
    }
    
    // this function is called when the user is chaning the bill amount
    // or the percentage rate
    @IBAction func whileChaningBillAmount(sender: AnyObject) {
        updateReceipt()
    }
    
    @IBAction func whileChangingPercentageAmount(sender: AnyObject) {
        updateReceipt()
    }
    
    // this function is called after editing the bill amount to reformat the field
    @IBAction func AfterChangingBillAmount(sender: AnyObject) {
        updateBillPercentageAmounts(getCurrentBillAmount(), currentPercentageRate: getCurrentPercentageRate())
        if(BillAmountValue.text != nil){
            let tipByRatingControllerReference = self.tabBarController!.viewControllers![1] as! TipByRatingViewController
            tipByRatingControllerReference.passedBillAmount = BillAmountValue.text
            self.passedBillAmount = BillAmountValue.text
        }
    }
    
    func updateBillPercentageAmounts(currentBillAmount: Double, currentPercentageRate: Double) {
        if(currentBillAmount < 0 || currentPercentageRate < 0){
            return;
        }
        BillAmountValue.text = String(currentBillAmount.asLocaleCurrency)
        BillAmountValue.placeholder = String(currentBillAmount.asLocaleCurrency)
        PercentageAmountValue.text = String(Int(currentPercentageRate * 100)) + "%"
        PercentageAmountValue.placeholder = String(Int(currentPercentageRate * 100)) + "%"
        tipPercentageSlider.value = Float(currentPercentageRate * 100)
        updateSatisfactoryEmoji()
    }
    
    // this function gets the current bill amount as a double
    func getCurrentBillAmount() -> Double {
        if(BillAmountValue.text != nil){
            var retCurrentBillAmount = ""
            for char in BillAmountValue.text!.characters {
                if(char >= "0" && char <= "9" || char == "."){
                    retCurrentBillAmount += String(char)
                }
            }
            if(retCurrentBillAmount != ""){
                return Double(retCurrentBillAmount)!
            }
        }
        return 0
    }
    
    func setCurrentPercentage(currentPercentage: Double) {
        PercentageAmountValue.text = String(Int(currentPercentage)) + "%"
        PercentageAmountValue.placeholder = String(Int(currentPercentage)) + "%"
        tipPercentageSlider.value = Float(currentPercentage)
        recieptTipAmountLabel.text = "Tip (" + String(Int(currentPercentage)) + "%):"
        updateSatisfactoryEmoji()
    }
    
    // this is a helper function that updates the values of the
    // "receipt"
    func updateReceipt() {
        let currentBillAmount = getCurrentBillAmount()
        let currentPercentageRate = getCurrentPercentageRate()
        if(currentBillAmount < 0 || currentPercentageRate < 0){
            return;
        }
        let currentTipAmount = currentBillAmount * currentPercentageRate
        let currentBillTotal = (currentBillAmount + currentTipAmount) / recieptSplitterStepper.value
        recieptBillAmountValue.text = String(currentBillAmount.asLocaleCurrency)
        recieptTipAmountValue.text = String(currentTipAmount.asLocaleCurrency)
        recieptTotalAmountValue.text = String(currentBillTotal.asLocaleCurrency) + "/" + String(Int(recieptSplitterStepper.value))
        if(recieptSplitterStepper.value == 1){
            recieptTotalAmountValue.text! += " person"
        } else {
            recieptTotalAmountValue.text! += " people"
        }
        recieptTipAmountLabel.text = "Tip (" + String(Int(getCurrentPercentageRate() * 100)) + "%):"
    }
    
    // this is a helper function that updates the emoji's that
    // correspond to the percentage rate
    func updateSatisfactoryEmoji() {
        let currentPercentageRate = getCurrentPercentageRate()
        switch (currentPercentageRate * 100) {
        case let x where x <= 5:
            satisfactoryEmoji.text = "😡"
        case let x where x >= 6 && x < 10:
            satisfactoryEmoji.text = "☹️"
        case let x where x >= 10 && x < 15:
            satisfactoryEmoji.text = "😐"
        case let x where x >= 15 && x < 20:
            satisfactoryEmoji.text = "🙂"
        case let x where x >= 20 && x < 25:
            satisfactoryEmoji.text = "😃"
        case let x where x >= 25 && x < 30:
            satisfactoryEmoji.text = "😘"
        default:
            satisfactoryEmoji.text = "😍"
        }
    }
    
    // this function gets the current percentage rate as a double
    func getCurrentPercentageRate() -> Double {
        if(PercentageAmountValue.text != nil){
            var retPercentageRate = ""
            for char in PercentageAmountValue.text!.characters {
                if(char != "%"){
                    retPercentageRate += String(char)
                }
            }
            if(retPercentageRate != ""){
                return (Double(retPercentageRate)!) / 100
            }
        }
        return (defaultUserData.doubleForKey("DefaultTipByPercentage") / 100)
    }
    
    // this function is called when the tip slider starts to change
    // its values
    @IBAction func whileChangingSlider(sender: UISlider) {
        PercentageAmountValue.text = String(Int(sender.value)) + "%"
        updateReceipt()
        updateSatisfactoryEmoji()
    }
    
    // this function is called when the slider is done changing
    @IBAction func afterStepAmountChanged(sender: AnyObject) {
        updateReceipt()
    }
}
