//
//  ResultTableViewCell.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblShipping: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadWithData(_ item: ResultWrapper) {
        self.lblTitle?.text = item.title
        self.lblPrice?.text = "$ \(item.price)"
        self.accessoryType = .disclosureIndicator
        var image: UIImage
        
        if let thumbnail = item.thumbnail {
            do {
                if let urll = URL(string: thumbnail) {
                    let data = try Data(contentsOf: urll)
                    image = UIImage(data: data)!
                } else {
                    print("No pudo convertir url: \(thumbnail) con \(item.id)")
                    image = UIImage(systemName: "shippingbox.fill")!
                }
            } catch {
                image = UIImage(systemName: "shippingbox.fill")!
            }
        } else {
            print("No hay thumbnail id \(item.id)")
            image = UIImage(systemName: "shippingbox.fill")!
        }
        self.imgThumbnail?.image = image
        if let freeShipping = item.freeShipping {
            lblShipping.isHidden = !freeShipping
        } else {
            lblShipping.isEnabled = false
        }
    }
    
}

