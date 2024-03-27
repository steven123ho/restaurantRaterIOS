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
    
    //star images
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    var rating: Int = 0
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
        
        // Set initial rating to 0 and update star UIImageViews
        rating = 0
        updateStarImageViews()
        
        // Add tap gesture recognizers to each star image view
        addTapGesture(to: star1, withTag: 1)
        addTapGesture(to: star2, withTag: 2)
        addTapGesture(to: star3, withTag: 3)
        addTapGesture(to: star4, withTag: 4)
        addTapGesture(to: star5, withTag: 5)
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
        currentDish?.rating = String(rating)
        return true
    }
    
    
    //star review functionality
    func addTapGesture(to imageView: UIImageView, withTag tag: Int) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
            imageView.addGestureRecognizer(tap)
            imageView.isUserInteractionEnabled = true
            imageView.tag = tag
        }
        
    @objc func starTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedStarImageView = sender.view as? UIImageView else { return }
            
        // Determine which star UIImageView was tapped
        let tappedStarIndex = tappedStarImageView.tag
        
        // Update the rating based on the tapped star
        rating = tappedStarIndex
            
        // Update the appearance of the star UIImageViews
        updateStarImageViews()
    }
        
    func updateStarImageViews() {
        // Update star UIImageViews up to the selected rating
        star1.image = UIImage(systemName: rating >= 1 ? "star.fill" : "star")
        star2.image = UIImage(systemName: rating >= 2 ? "star.fill" : "star")
        star3.image = UIImage(systemName: rating >= 3 ? "star.fill" : "star")
        star4.image = UIImage(systemName: rating >= 4 ? "star.fill" : "star")
        star5.image = UIImage(systemName: rating >= 5 ? "star.fill" : "star")
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
