//
//  DetailedController.swift
//  CollectionViewLab
//
//  Created by Cameron Rivera on 1/14/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class DetailedController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    
    var currentCountry: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
