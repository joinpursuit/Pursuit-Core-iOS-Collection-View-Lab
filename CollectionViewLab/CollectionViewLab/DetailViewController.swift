//
//  DetailViewController.swift
//  CollectionViewLab
//
//  Created by Michelle Cueva on 9/26/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    var country: Country!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = country.name

    }
    

}
