//
//  ViewController.swift
//  demo15
//
//  Created by MYLAVARAPU SESHA S on 10/15/19.
//  Copyright © 2019 MYLAVARAPU SESHA S. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentTextField: UITextField!
    @IBOutlet weak var deptAbbr: UITextField!
    @IBOutlet weak var courseNum: UITextField!
    @IBOutlet weak var coureTitle: UITextField!
    
    //default values
    var deptAbbrResult = ""
    var courseNumResult: Int16 = 0
    var courseTitleResult = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Tap gesture if you click anywhere in the view it ends editing dismissing the keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        deptAbbr.delegate = self
        deptAbbr.tag = 0
    }
    
    //if you tap return will tab to next textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let next = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            next.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    //sets deptAbbr as starting field and shows keyboard automatically
    override func viewDidAppear(_ animated: Bool) {
        deptAbbr.becomeFirstResponder()
    }
    
    //checks before seque is performed if all the textfields have no whitespaces or are empty before continuing, if they do, they user will be alerted
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "saveCourse" {
            checkFilled: if deptAbbr.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true || courseNum.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true || coureTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                let alertController = UIAlertController(title: "Empty Textfields", message: "Please enter valid data in each field or press 'Back' to cancel!" , preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alertController, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        deptAbbrResult = deptAbbr.text ?? "Bad DeptAbbr"
        courseNumResult = Int16(courseNum.text ?? "-1")!
        courseTitleResult = coureTitle.text ?? "Bad Title"
    }

}

