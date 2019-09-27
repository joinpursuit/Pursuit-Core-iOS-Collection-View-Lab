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
    
    @IBOutlet weak var capitalLabel: UILabel!
    
    @IBOutlet weak var populationLabel: UILabel!
    
    @IBOutlet weak var countryImage: UIImageView!
    
    var country: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        loadImage()

    }
    
    private func configureLabels() {
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = country.population.description
    }
    
    private func loadImage() {
        ImageHelper.shared.getImage(urlStr: CountryAPIClient.getFlagUrl(from: country.alpha2Code)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageFromOnline):
                    self.countryImage.image = imageFromOnline
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
