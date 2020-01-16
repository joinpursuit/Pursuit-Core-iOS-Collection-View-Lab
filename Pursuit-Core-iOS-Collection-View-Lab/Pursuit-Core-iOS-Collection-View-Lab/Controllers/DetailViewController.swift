//
//  DetailViewController.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Bienbenido Angeles on 1/16/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

   var passedObj: CountryList?
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var countryLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureData()
    }
    
    func configureData(){
        guard let validCountry = passedObj else {
            fatalError("failed to unwrap country, check on view controller if countries is nil")
        }
        
        
        imageView.getImage(with: "https://www.countryflags.io/\(validCountry.alpha2Code)/flat/64.png") { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(systemName: "person.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        countryLabel.text = "Country: \(validCountry.name)\nCapital: \(validCountry.capital)\nPopulation: \(validCountry.population)"
    }
}
