//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Mogulla, Naveen on 2/28/17.
//  Copyright © 2017 Mogulla, Naveen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
  
    @IBOutlet weak var labelBill: UILabel!
    
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var labelTip: UILabel!
    let userDefaults = UserDefaults.standard
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var currencySymbol = "$"
        
         //To clear userDefaults value
        /*
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        */
        //load the default settings
        if userDefaults.object(forKey: "language") == nil {
             loadDefaults()
        }
        becomeFirstResponder()
        
        billField.text = ""
        
        if ( userDefaults.integer(forKey: "selectedLanguageIndex")  == 0 ){
            labelTotal.text = "Total"
            labelTip.text = "Tip"
            labelBill.text = "Bill"
        } else if ( userDefaults.integer(forKey: "selectedLanguageIndex") == 1 ) {
            labelBill.text = "Cuenta"
            labelTip.text = "Propina"
            labelTotal.text = "Total"
        }
        
        if (userDefaults.integer(forKey: "selectedCurrencyIndex") == 0){
            currencySymbol = "$"
        } else if (userDefaults.integer(forKey: "selectedCurrencyIndex") == 1){
            currencySymbol = "MEX$"
        }
        tipControl.selectedSegmentIndex = userDefaults.integer(forKey: "selectedTipIndex")
       
        tipLabel.text = String(format: "%@0.00",  currencySymbol)
        totalLabel.text = tipLabel.text
       
    }
    
    func loadDefaults(){
        let tipPercentages = [ "18%", "20%", "25%"]
        let languages = ["English", "Spanish"]
        let currencies = ["USD", "Mexican Peso"]
        
        userDefaults.set(languages, forKey: "languages")
        userDefaults.set(currencies, forKey: "currencies")
         userDefaults.set (tipPercentages, forKey: "tipPercentages")
        
        userDefaults.set("English", forKey: "language")
        userDefaults.set("USD", forKey: "currency")
        userDefaults.set("25%", forKey: "tip")
        
        userDefaults.set(0, forKey: "selectedLanguageIndex")
        userDefaults.set(0, forKey: "selectedCurrencyIndex")
        userDefaults.set(2, forKey: "selectedTipIndex")
        
        userDefaults.set("$", forKey: "USD")
        userDefaults.set("MEX$", forKey: "Mexican Peso")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTap(_ sender: Any) {
      view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = [0.18, 0.2, 0.25]
        var currencySymbol = "$"
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        if (userDefaults.integer(forKey: "selectedCurrencyIndex") == 0){
            currencySymbol = "$"
        } else if (userDefaults.integer(forKey: "selectedCurrencyIndex") == 1){
            currencySymbol = "MEX$"
        }
        tipLabel.text = String(format: "%@%.2f",  currencySymbol, tip)
        totalLabel.text = String(format: "%@%.2f", currencySymbol, total)
        
    }
    
    @IBAction func didPercentageChange(_ sender: Any) {
        calculateTip(self)
    }
}

