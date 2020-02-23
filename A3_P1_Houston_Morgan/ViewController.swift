//
//  ViewController.swift
//  A3_P1_Houston_Morgan
//
//  Created by Morgan Houston on 9/29/19.
//  Copyright © 2019 Morgan Houston. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(true)
        // Hide the navigation bar and toolbar.
        self.navigationController?.setToolbarHidden( true, animated: true)
        self.navigationController?.setNavigationBarHidden(true,animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }


}

