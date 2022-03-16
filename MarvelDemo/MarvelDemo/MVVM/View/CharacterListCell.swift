//
//  CharacterListCell.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 12/03/22.
//
//

import UIKit
import Kingfisher

class CharacterListCell: UITableViewCell {

    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var model: CharacterModel?{
        didSet{
            firstnameLabel.text = model?.name
            let thumbnailstr = "\(model?.thumbnail["path"] ?? "").jpg"
            
            let url = URL(string: thumbnailstr)
            profileImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.circle.fill"))
            profileImageView.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
