//
//  WikiTableCell.swift
//  Saurabh_MT
//
//  Created by saurabh srivastava on 29/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit
import Kingfisher

class WikiTableCell: UITableViewCell {

    @IBOutlet weak var desclabel: UILabel!
    @IBOutlet weak var title: UILabel!
   
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(_ data:Result){
        self.userImage.kf.setImage(with: URL(string: data.image))
        title.text = data.title.capitalized
        desclabel.text = data.desc
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
