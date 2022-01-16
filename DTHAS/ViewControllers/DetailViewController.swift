//
//  DetailViewController.swift
//  DTHAS
//
//  Created by Shanezzar Sharon on 15/01/2022.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    // MARK:- variables
    @IBOutlet weak var gifImageView: SDAnimatedImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var tIdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var id: String = ""
    
    let networkModel = NetworkModel()
    
    
    // MARK:- functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupUI() {
        gifImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        gifImageView.contentMode = .scaleAspectFill
        gifImageView.layer.cornerRadius = 8
        
    }
    
    func setup() {
        networkModel.fetchGIF(id) { gif, error in
            if let error = error {
                let alert = UIAlertController(title: "Ops!", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            guard let gif = gif else { return }
            
            DispatchQueue.main.async {
                self.gifImageView.sd_setImage(with: URL(string: gif.image.downsizedMedium.url))
                self.idLabel.text = gif.id.isEmpty ? "..." : gif.id
                self.tIdLabel.text = gif.tld.isEmpty ? "..." : gif.tld
                self.titleLabel.text = gif.title.isEmpty ? "..." : gif.title
                self.byLabel.text = gif.username.isEmpty ? "..." : gif.username
                self.ratingLabel.text = gif.rating.isEmpty ? "..." : gif.rating
            }
        }
        
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        haptic()
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
