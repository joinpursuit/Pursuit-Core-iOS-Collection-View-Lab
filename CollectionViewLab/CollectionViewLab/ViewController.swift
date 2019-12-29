//
//  ViewController.swift
//  CollectionViewLab
//
//  Created by Ahad Islam on 12/25/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var countries = [Country]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            let indexPath = collectionView.indexPathsForSelectedItems![0]
            destination.country = countries[indexPath.row]
        }
    }
    
    private func loadData(url: String = "https://restcountries.eu/rest/v2/name/united") {

        GenericCoderService.manager.getJSON(objectType: [Country].self, with: url) { result in
            switch result {
            case .failure(let error):
                print("Error occurred decoding JSON from \(url) to countries: \(error)")
            case .success(let countriesFromAPI):
                self.countries = countriesFromAPI
            }
        }
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Country Cell", for: indexPath) as? CountryCollectionViewCell else {
            print("Could not create custom cell with reuseIdentifier")
            return UICollectionViewCell()
        }
        
        cell.configureCell(country: countries[indexPath.row])
        
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return false
        }
        
        let url = "https://restcountries.eu/rest/v2/name/\(text)"
        loadData(url: url)
        resignFirstResponder()
        return true
    }
}
