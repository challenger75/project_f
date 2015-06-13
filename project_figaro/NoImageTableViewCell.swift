//
//  NoImageTableViewCell.swift
//  project_figaro
//
//  Created by Florian Letellier on 13/06/2015.
//  Copyright (c) 2015 Florian Letellier. All rights reserved.
//

import UIKit

class NoImageTableViewCell: UITableViewCell {

    @IBOutlet weak var NoImageLabel: UILabel!

    func configureCellWith(article: Article)
    {
        NoImageLabel.text = article.title
    }

}
