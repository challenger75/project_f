//
//  Article.swift
//  project_figaro
//
//  Created by Florian Letellier on 12/06/2015.
//  Copyright (c) 2015 Florian Letellier. All rights reserved.
//

import Foundation

class Article {
    var title: String
    var subtitle: String
    var photos: String

    init(title: String, subtitle: String, photos: String)
    {
        self.title = title
        self.subtitle = subtitle
        self.photos = photos
    }
}