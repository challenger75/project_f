//
//  ViewController.swift
//  project_figaro
//
//  Created by Florian Letellier on 12/06/2015.
//  Copyright (c) 2015 Florian Letellier. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var articles: [Article] = [] /* We'll store each article in an object array */
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        get_json()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       /*We display differently the article according to their position (first or not) and if they have picture or not */
        if (indexPath.row == 0)
        {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("FirstCell") as! FirstTableViewCell
            cell.configureCellWith(self.articles[indexPath.row])
            self.tableView.rowHeight = 220.0
            return cell
        }
        else
        {
            self.tableView.rowHeight = 80.0
            if (self.articles[indexPath.row].photos != "")
            {
                let cell = self.tableView.dequeueReusableCellWithIdentifier("LittleCell") as!
                LittleTableViewCell
                cell.configureCellWith(self.articles[indexPath.row])
                return cell
            }
            else
            {
                let cell = self.tableView.dequeueReusableCellWithIdentifier("NoImageCell") as!
                NoImageTableViewCell
                cell.configureCellWith(self.articles[indexPath.row])
                return cell
            }
        }

    }

    func get_json()
    {
        let url = NSURL(string: "http://figaro.service.yagasp.com/articlesv6/w4ljb25vbWllVGVjaCAmIFdlYg==/")
        var i = 0
        
        /* We get the json file */
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if error != nil
            {
                println("Error has occured")
            }
            else
            {
                var parseError: NSError?
                let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
                    options: NSJSONReadingOptions.AllowFragments,
                    error:&parseError)
                var title: String
                var subtitle: String
                var photos: String
                var start:  String.Index?

                /* We iterate through each article to get title, subtitle, photos and we store it in the article object*/
                let ranking: NSDictionary = (parsedObject as? NSDictionary)!
                while (i < ranking["rankings"]!.count)
                {
                    if let article = parsedObject as? NSDictionary {
                        if let index = article["articles"] as? NSArray {
                            if let tags = index[i] as? NSDictionary
                            {
                                let title = tags["title"] as? String
                                let subtitle = tags["subtitle"] as? String
                                if let photo = tags["photos"] as? NSArray
                                {
                                    if photo.count > 0
                                    {
                                        if let first = photo[0] as? NSDictionary
                                        {
                                            if var photos = first["url"] as? String
                                            {
                                            /* if there is a photo we get the param of the url to get the link of the picture */
                                                start = photos.rangeOfString("?url=")?.endIndex
                                                photos = photos.substringFromIndex(start!)
                                                var article = Article(title: title!, subtitle: subtitle!, photos: photos)
                                                 self.articles.append(article)
                                            }
                                        }
                                    }
                                    else
                                    {
                                        photos = ""
                                        var article = Article(title: title!, subtitle: subtitle!, photos: photos)
                                        self.articles.append(article)
                                    }
                                }

                            }
                        }
                    }
                    
                   
                    i++

                    /* We create and initialize our Article object and append it in the array */
                }
                /* let's reload the tableView to display what we got from the json */
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
            task.resume()
    }
}

