//
//  DetailViewController.swift
//  CollectionViewProj
//
//  Created by Kevin Natera on 9/30/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    var country: Country!
    
    @IBOutlet weak var flagOutlet: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
     
    
    private func loadData() {
        nameLabel.text = country.name
        capitalLabel.text = "Capital: \(country.capital)"
        popLabel.text = "Population: \(country.population)"
        
        let urlStr = "https://www.countryflags.io/\(country.alpha2Code.lowercased())/shiny/64.png"
        ImageHelper.shared.getImage(urlStr: urlStr) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.flagOutlet.image = image
                }
            }
        }
    }
}
