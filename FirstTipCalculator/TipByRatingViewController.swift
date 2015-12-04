//
//  TipByRatingViewController.swift
//  FirstTipCalculator
//
//  Created by Faisal Abu Jabal on 12/2/15.
//  Copyright © 2015 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class TipByRatingViewController: UIViewController {
    
    let defaultUserData = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var BillAmountTextField: UITextField!
    @IBOutlet weak var RatingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var SatisfactoryEmoji: UILabel!
    @IBOutlet weak var ReceiptBillAmount: UILabel!
    @IBOutlet weak var RecieptStepper: UIStepper!
    @IBOutlet weak var RecieptTotalAmount: UILabel!
    @IBOutlet weak var ReceiptTipAmount: UILabel!
    @IBOutlet weak var RecieptTipAmountLabel: UILabel!
    @IBOutlet weak var SwipeToDismissKeyboardLabel: UIView!
    @IBOutlet weak var SwipeToDismissImage: UIImageView!
    
    var passedBillAmount: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the default values
        
        if(passedBillAmount != nil){
            BillAmountTextField.text = passedBillAmount!
            BillAmountTextField.placeholder = passedBillAmount!
            updateReciept()
        } else {
            BillAmountTextField.text = String(Double(0).asLocaleCurrency)
            BillAmountTextField.placeholder = String(Double(0).asLocaleCurrency)
        }
        ReceiptBillAmount.text = String(Double(0).asLocaleCurrency)
        RecieptTotalAmount.text = String(Double(0).asLocaleCurrency)
        RecieptTotalAmount.text = String(Double(0).asLocaleCurrency) + "/1 person"
        
        let currentDefaultStar = defaultUserData.integerForKey("DefaultStarRating") as Int?
        if(currentDefaultStar != nil){
            RatingSegmentedControl.selectedSegmentIndex = currentDefaultStar! - 1
        } else {
            defaultUserData.setInteger(3, forKey: "DefaultStarRating")
            defaultUserData.synchronize()
        }
        updateSatisfactoryEmoji()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(passedBillAmount != nil){
            BillAmountTextField.text = passedBillAmount!
            BillAmountTextField.placeholder = passedBillAmount
        }
        
        RatingSegmentedControl.selectedSegmentIndex = Int(defaultUserData.integerForKey("DefaultStarRating") - 1)
        updateReciept()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        SwipeToDismissImage.alpha = 1
        SwipeToDismissKeyboardLabel.alpha = 1
    }
    
    func keyboardWillHide(notification: NSNotification){
        SwipeToDismissImage.alpha = 0
        SwipeToDismissKeyboardLabel.alpha = 0
    }
    
    
    @IBAction func WhileEditingBillAmountTextField(sender: AnyObject) {
        updateReciept()
    }
    
    
    @IBAction func AfterEditingBillAmountTextField(sender: AnyObject) {
        BillAmountTextField.text = String(getCurrentBillAmount().asLocaleCurrency)
        BillAmountTextField.placeholder = String(getCurrentBillAmount().asLocaleCurrency)
        if(BillAmountTextField.text != nil){
            let tipByPercentageControllerReference = self.tabBarController!.viewControllers![0] as! TipByPercentageViewController
            tipByPercentageControllerReference.passedBillAmount = BillAmountTextField.text
            self.passedBillAmount = BillAmountTextField.text
        }
    }
    
    
    @IBAction func AfterEditingStepper(sender: AnyObject) {
        updateReciept()
    }
    
    
    @IBAction func AfterEditingSegmentedControl(sender: AnyObject) {
        updateReciept()
        updateSatisfactoryEmoji()
    }
    
    // this is a helper function that updates the emoji's that
    // correspond to the percentage rate
    func updateSatisfactoryEmoji() {
        let currentStarIndex = RatingSegmentedControl.selectedSegmentIndex
        switch (currentStarIndex) {
        case 0:
            SatisfactoryEmoji.text = "😡"
        case 1:
            SatisfactoryEmoji.text = "☹️"
        case 2:
            SatisfactoryEmoji.text = "🙂"
        case 3:
            SatisfactoryEmoji.text = "😃"
        case 4:
            SatisfactoryEmoji.text = "😍"
        default:
            SatisfactoryEmoji.text = "🙂"
        }
    }
    
    func getCurrentTipValueFromSegmentedControl() -> Int {
        let currentStarIndex = RatingSegmentedControl.selectedSegmentIndex
        switch currentStarIndex {
        case 0:
            return Int(defaultUserData.doubleForKey("DefaultOneStarPercentage"))
        case 1:
            return Int(defaultUserData.doubleForKey("DefaultTwoStarsPercentage"))
        case 2:
            return Int(defaultUserData.doubleForKey("DefaultThreeStarsPercentage"))
        case 3:
            return Int(defaultUserData.doubleForKey("DefaultFourStarsPercentage"))
        case 4:
            return Int(defaultUserData.doubleForKey("DefaultFiveStarsPercentage"))
        default:
            return Int(defaultUserData.doubleForKey("DefaultThreeStarsPercentage"))
        }
    }
    
    func updateReciept() {
        ReceiptBillAmount.text = String(Double(getCurrentBillAmount()).asLocaleCurrency)
        RecieptTipAmountLabel.text = "Tip (" + String(getCurrentTipValueFromSegmentedControl()) + "%):"
        let tipAmount = getCurrentBillAmount() * Double(getCurrentTipValueFromSegmentedControl()) / 100
        ReceiptTipAmount.text = String(tipAmount.asLocaleCurrency)
        RecieptTotalAmount.text = String(((tipAmount + getCurrentBillAmount()) / RecieptStepper.value).asLocaleCurrency) + "/" + String(Int(RecieptStepper.value))
        if(RecieptStepper.value == 1){
            RecieptTotalAmount.text! += " person"
        } else {
            RecieptTotalAmount.text! += " people"
        }
    }
    
    // this function gets the current bill amount as a double
    func getCurrentBillAmount() -> Double {
        if(BillAmountTextField.text != nil){
            var retCurrentBillAmount = ""
            for char in BillAmountTextField.text!.characters {
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
    
    @IBAction func OnTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func SwipingRight(sender: AnyObject) {
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func SwipingLeft(sender: AnyObject) {
        tabBarController?.selectedIndex = 2
    }
    
}
