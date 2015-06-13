//
//  FirstTableViewCell.swift
//  
//
//  Created by Florian Letellier on 13/06/2015.
//
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var bigImage: UIImageView!
  
    @IBOutlet weak var bigLabel: UILabel!
    
    func configureCellWith(article: Article)
    {
        let url = NSURL(string: article.photos)
        let data = NSData(contentsOfURL: url!)
        var image : UIImage = UIImage(data: data!)!
        bigImage.image = image
        
        bigLabel.text = article.title
    }
}
