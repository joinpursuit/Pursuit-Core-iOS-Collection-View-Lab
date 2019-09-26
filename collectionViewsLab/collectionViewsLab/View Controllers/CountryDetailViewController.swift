//
//  CountryDetailViewController.swift
//  collectionViewsLab
//
//  Created by Sam Roman on 9/26/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {
    
    var country: Countries!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var capital: UILabel!
    
    @IBOutlet weak var population: UILabel!
    
    @IBOutlet weak var flag: UIImageView!
    
    private func loadDetails(){
        name.text = country.name
        capital.text = "Capital: \(country.capital)"
        population.text = "Pop: \(country.population)"
        ImageHelper.shared.fetchImage(urlString: country.imageURL) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let image):
                    self.flag.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        loadDetails()
        super.viewDidLoad()


    }
    



}
