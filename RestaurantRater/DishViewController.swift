//
//  DishViewController.swift
//  RestaurantRater
//
//  Created by user246123 on 3/24/24.
//

import UIKit

class DishViewController: UIViewController, UITextFieldDelegate{
    var currentDish: Dish?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var txtDishName: UITextField!
    @IBOutlet weak var txtDishType: UITextField!
    @IBOutlet weak var restaurantPlaceholder: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let textFields: [UITextField] = [txtDishName, txtDishType]
        
        for textfield in textFields {
            textfield.addTarget(self,
                                action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)),
                                for: UIControl.Event.editingDidEnd)
        }
        
        //Getting restaurantName
        if let restaurantName = UserDefaults.standard.string(forKey: "restaurantName") {
            self.restaurantPlaceholder.text = restaurantName
        }
    }
    
    @IBAction func submitDish(_ sender: Any) {
        let textFields: [UITextField] = [txtDishName, txtDishType]

        appDelegate.saveContext()
        
        for textField in textFields {
            textField.isEnabled = false
            textField.borderStyle = UITextField.BorderStyle.none
        }

     }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if currentDish == nil {
            let context = appDelegate.persistentContainer.viewContext
            currentDish = Dish(context: context)
        }
        currentDish?.name = txtDishName.text
        currentDish?.type = txtDishType.text
        currentDish?.restaurantName = restaurantPlaceholder.text
        return true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
