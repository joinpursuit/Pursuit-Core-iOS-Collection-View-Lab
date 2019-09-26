//
//  ViewController.swift
//  Collection-View-Lab
//
//  Created by Sunni Tang on 9/26/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {

    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    var countries = [Country]() {
        didSet {
            countryCollectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = countryCollectionView.indexPath(for: sender as! UICollectionViewCell) else { print("no index selected")
            return }
        guard segue.identifier == "countryToDetailSegue" else { print("no ID'd segue")
            return }
        guard let countryDetailVC = segue.destination as? CountryDetailViewController else {
            print("no destination VC")
            return }

        countryDetailVC.country
         = countries[selectedIndex.row]
        
    }
    
    
    private func configureCollectionView() {
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
    }

    private func loadData() {
        CountryAPIClient.manager.getCountries { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let dataFromOnline):
                    self.countries = dataFromOnline
                }
            }
        }
    }
    

    
}

extension CountryListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCollectionViewCell else {
            fatalError("no cell ID")
        }
        
        let country = countries[indexPath.row]
        
        countryCell.nameLabel.text = country.name
        countryCell.capitalLabel.text = country.capital
        countryCell.populationLabel.text = String(country.population)
        
        ImageHelper.manager.getImage(urlStr: CountryAPIClient.getFlagImageURLStr(from: country.code)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    countryCell.flagImageView.image = imageFromOnline
                }
            }
        }
        
        return countryCell
    }
    
    
}

extension CountryListViewController: UICollectionViewDelegateFlowLayout {}
