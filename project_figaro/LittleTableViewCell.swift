//
//  LittleTableViewCell.swift
//  project_figaro
//
//  Created by Florian Letellier on 13/06/2015.
//  Copyright (c) 2015 Florian Letellier. All rights reserved.
//

import UIKit

class LittleTableViewCell: UITableViewCell {

    @IBOutlet weak var littleImage: UIImageView!
    @IBOutlet weak var littleLabel: UILabel!

    func configureCellWith(article: Article)
    {
        let url = NSURL(string: article.photos)
        let data = NSData(contentsOfURL: url!)
        var image : UIImage = UIImage(data: data!)!
        littleImage.image = image
        littleLabel.text = article.title
    }
}
