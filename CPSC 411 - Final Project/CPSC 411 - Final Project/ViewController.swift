//
//  ViewController.swift
//  CPSC 411 - Final Project
//
//  Created by csuftitan on 10/12/26.
//

import UIKit


// Minifigure Class to hold values displayed in Details
class Minifigure {
    // Type Properties
    var name: String
    var price: Double
    var count: Int
    var condition: String
    var description: String
    
    
    // Initializer
    init(name: String, price: Double, count: Int, condition: String, description: String) {
        self.name = name
        self.count = count
        self.price = price
        self.condition = condition
        self.description = description
    }
}



// Home screen, all Storyboard implemented
class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}



// Main scene Portfolio displaying UITableView
class PortfolioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    
    // Store Minifigures, temporary minifgures for reference
    var minifiguresArray: [Minifigure] = [
        Minifigure(name: "Oswald",  price: 7.99, count: 2, condition: "new", description: "Disney 100 CMF"),
        Minifigure(name: "Boba Fett - Cloud City", price: 1500.0, count: 1, condition: "used", description: "Lotta money"),
        Minifigure(name: "Kai - Legacy", price: 1.40, count: 5, condition: "new", description: "Very common"),
        Minifigure(name: "Jestro - Electric", price: 15.0, count: 1, condition: "used", description: "It ended too early"),
        Minifigure(name: "Lennox", price: 1.10, count: 3, condition: "new", description: "Army builder"),
        Minifigure(name: "Finn the Human", price: 35.0, count: 1, condition: "used", description: "Adventure Time"),
        Minifigure(name: "Donald Duck - Series 1", price: 10.0, count: 3, condition: "new", description: "Quack"),
        Minifigure(name: "Zinnia", price: 53.0, count: 1, condition: "new", description: "Delta Episode"),
        Minifigure(name: "Johnny Thunder (Desert)", price: 1.70, count: 2, condition: "used", description: "OG Explorer")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // Templete from In-class UITableView reference code
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showDetails" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let detailVC = segue.destination as! DetailsViewController
                detailVC.tempMinifigure = minifiguresArray[row]
            }
        }
    }
    
    
    // Templete from In-class UITableView reference code
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return number of minifigures in array
        return minifiguresArray.count
    }
    
    
    // Structured as In-class UITableView code
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MinifigureCell", for: indexPath)
        
        // Cell configured to display minifigure object's name
        cell.textLabel?.text = minifiguresArray[indexPath.row].name
        
        return cell
    }
    
    
    // Structured as In-class UITableView code, altered body for removing objects
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Remove object from minifigures array
        minifiguresArray.remove(at:indexPath.row)
        
        // Remove row visually
        tableView.deleteRows(at:[indexPath], with: .fade)
    }
    
    
    // Currently deletes rows, add functionality for edit later
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        // Activate or Deactivate Editing mode when pressed
        tableView.setEditing(!(tableView.isEditing), animated: true)
    }
    
    
    // Dismiss page, don't open new Home Scene, deletes existing table data
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        // Apple Developer page: dismiss(animated:completion:)
        dismiss(animated: true, completion: nil)
    }
}



class AddViewController: UIViewController {
    
    // Validation Labels
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var priceLabel : UILabel!
    @IBOutlet var countLabel : UILabel!
    @IBOutlet var conditionLabel : UILabel!
    @IBOutlet var descriptionLabel : UILabel!
    
    
    // Text Fields
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var priceTextField : UITextField!
    @IBOutlet var countTextField : UITextField!
    @IBOutlet var conditionTextField : UITextField!
    @IBOutlet var descriptionTextField : UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // Dismiss page, return to current Portfolio page
    @IBAction func portfolioButtonPressed(_ sender: UIButton) {
        // Apple Developer page: dismiss(animated:completion:)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        // Legal Tracker, if anything flags then don't create object
        var legal: Bool = true
        
        
        // Placeholders, used to create Minifigure object
        var tempName: String = ""
        var tempPrice: Double = 0.0
        var tempCount: Int = 0
        var tempCondition: String = ""
        var tempDescription: String = ""
        
        
        // Constant Strings for label descriptions
        let nilMsg: String = " is nil"
        let emptyMsg: String = " is empty"
        let validMsg: String = " is VALID"
        
        
        // Validate Name
        if let text = nameTextField.text {
            // Check if exists
            if !(text.isEmpty) {
                tempName = text
                nameLabel.text = ("Name" + validMsg)
            } else {
                legal = false
                nameLabel.text = ("Name" + emptyMsg)
            }
        } else {
            legal = false
            nameLabel.text = ("Name" + nilMsg)
        }
        
        
        // Validate Price
        if let text = priceTextField.text {
            // Check if exists
            if !(text.isEmpty) {
                // Check Boolean conversion
                if let price = Double(text) {
                    // Check non-negative
                    if (price > 0.0) {
                        tempPrice = price
                        priceLabel.text = ("Price" + validMsg)
                    } else {
                        legal = false
                        priceLabel.text = "Price must be positive"
                    }
                } else {
                    legal = false
                    priceLabel.text = "Price must be a Double"
                }
            } else {
                legal = false
                priceLabel.text = ("Price" + emptyMsg)
            }
        } else {
            legal = false
            priceLabel.text = ("Price" + nilMsg)
        }
        
        
        // Validate Count
        if let text = countTextField.text {
            // Check if exists
            if !(text.isEmpty) {
                // Check Integer conversion
                if let count = Int(text) {
                    // Check non-negative
                    if (count > 0) {
                        tempCount = count
                        countLabel.text = ("Count" + validMsg)
                    } else {
                        legal = false
                        countLabel.text = "Count must be >= 1"
                    }
                } else {
                    legal = false
                    countLabel.text = "Count must be a Integer"
                }
            } else {
                legal = false
                countLabel.text = ("Count" + emptyMsg)
            }
        } else {
            legal = false
            countLabel.text = ("Count" + nilMsg)
        }
        
        
        // Validate Condition
        if let text = conditionTextField.text {
            // Check if exists
            if !(text.isEmpty) {
                // Check if valid String new/used
                if (text.lowercased() == "new" ||
                    text.lowercased() == "used") {
                    tempCondition = text
                    conditionLabel.text = ("Condition" + validMsg)
                } else {
                    legal = false
                    conditionLabel.text = "Condition must be new/used"
                }
            } else {
                legal = false
                conditionLabel.text = ("Condition" + emptyMsg)
            }
        } else {
            legal = false
            conditionLabel.text = ("Condition" + nilMsg)
        }

        
        // Validate Description
        if let text = descriptionTextField.text {
            // Check if exists
            if !(text.isEmpty) {
                tempDescription = text
                descriptionLabel.text = ("Description" + validMsg)
            } else {
                legal = false
                descriptionLabel.text = ("Description" + emptyMsg)
            }
        } else {
            legal = false
            descriptionLabel.text = ("Description" + nilMsg)
        }
        
        
        // Flaged for at least one input
        if !(legal) { return }
        
        
        // Create new minifigure object
        let addedMinifig = Minifigure(name: tempName,price: tempPrice,
                                       count: tempCount, condition: tempCondition,
                                       description: tempDescription)
        
        
        // Apple Developer pages: presentingViewController, reloadData()
        if let portfolioVC = presentingViewController as? PortfolioViewController {
            portfolioVC.minifiguresArray.append(addedMinifig)
            portfolioVC.tableView.reloadData()
        }
        
        
        // Apple Developer page: dismiss(animated:completion:)
        dismiss(animated: true, completion: nil)
    }
}



class DetailsViewController: UIViewController {
    
    // Minifigure object passed
    var tempMinifigure: Minifigure?
    
    
    // UI Label Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var descriptionLabel: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set all labels to the object's variables
        if let minifigure = tempMinifigure {
            nameLabel.text = "Name: \(minifigure.name)"
            // Adjust to US dollar format
            priceLabel.text = String(format: "Price: $%.2f", minifigure.price)
            countLabel.text = "Count: \(minifigure.count)"
            conditionLabel.text = "Condition: \(minifigure.condition)"
            descriptionLabel.text = minifigure.description
        }
    }
    
    
    // Used to preserve data to a simplistic degree, without opening new scene
    @IBAction func portfolioButtonPressed(_ sender: UIButton) {
        // Apple Developer page: dismiss(animated:completion:)
        dismiss(animated: true, completion: nil)
    }
}
