//
//  ViewController.swift
//  RestaurantRater
//
//  Created by user246123 on 3/24/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var currentRestaurant: Restaurant?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var sgmtEditMode: UISegmentedControl!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let textFields: [UITextField] = [txtName, txtAddress]
        
        for textfield in textFields {
            textfield.addTarget(self,
                                action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)),
                                for: UIControl.Event.editingDidEnd)
        }
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if currentRestaurant == nil {
            let context = appDelegate.persistentContainer.viewContext
            currentRestaurant = Restaurant(context: context)
        }
        currentRestaurant?.name = txtName.text
        currentRestaurant?.address = txtAddress.text
        return true
    }
    
    
    
    @IBAction func saveRestaurant(_ sender: Any) {
        appDelegate.saveContext()
        sgmtEditMode.selectedSegmentIndex = 0
        changeEditMode(self)
    }
    
    
    @IBAction func changeEditMode(_ sender: Any) {
        let textFields: [UITextField] = [txtName, txtAddress]
        
        if sgmtEditMode.selectedSegmentIndex == 0 {
            for textField in textFields {
                textField.isEnabled = false
                textField.borderStyle = UITextField.BorderStyle.none
            }
            navigationItem.rightBarButtonItem = nil
        } else if sgmtEditMode.selectedSegmentIndex == 1 {
            for textField in textFields {
                textField.isEnabled = true
                textField.borderStyle = UITextField.BorderStyle.roundedRect
            }
        }
    }
    
}

