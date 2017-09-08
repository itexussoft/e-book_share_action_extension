//
//  ViewController.swift
//  doc_interaction_test
//
//  Created by Eugene Denisenko on 9/6/17.
//  Copyright © 2017 Eugene Denisenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let groupUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.itexus.booktest") {
            do {
                let subdirUrl = groupUrl.appendingPathComponent("books")
                let directoryContents = try FileManager.default.contentsOfDirectory(at: subdirUrl, includingPropertiesForKeys: nil, options: [])
                print(directoryContents)
                let epubFiles = directoryContents.filter{ $0.pathExtension == "epub" }
                print("epubFiles:",epubFiles)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
