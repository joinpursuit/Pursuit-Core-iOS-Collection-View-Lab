//
//  DetailViewController.swift
//  CollectionViewLab
//
//  Created by Ahad Islam on 12/29/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var country: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTextView()
        setupImageView()
    }
    
    private func setUpTextView() {
        let text = """
        \(country.name)
        \(country.capital)
        \(country.population)
        """
        
        textView.text = text
    }
    
    private func setupImageView() {
        let url = "https://www.countryflags.io/\(country.alpha2Code.lowercased())/shiny/64.png"
        
        imageView.getImage(with: url) { result in
            switch result {
            case.failure(let error):
                print("Error getting image: \(error)")
            case .success(let imageFromAPI):
                DispatchQueue.main.async {
                    self.imageView.image = imageFromAPI
                }
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
