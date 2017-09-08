//
//  ActionViewController.swift
//  book_action
//
//  Created by Eugene Denisenko on 9/7/17.
//  Copyright © 2017 Eugene Denisenko. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var bookFound = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                if provider.hasItemConformingToTypeIdentifier("org.idpf.epub-container") {
                    provider.loadItem(forTypeIdentifier: "org.idpf.epub-container", options: nil, completionHandler: { (bookURL, error) in
                        self.saveBookToURL(bookURL: bookURL as! URL, completion: { (success) in
                            print("book saved in shared storage")
                        })
                    })
                    bookFound = true
                    break
                }
            }
            if (bookFound) {
                break
            }
        }
    }
    
    func saveBookToURL(bookURL: URL, completion: (Bool) -> Void) {
        if let groupUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.itexus.booktest"), let bookData = NSData(contentsOf: bookURL)  {
            let subdirUrl = groupUrl.appendingPathComponent("books")
            do {
                if !FileManager.default.fileExists(atPath: subdirUrl.path) {
                    try FileManager.default.createDirectory(atPath: subdirUrl.path, withIntermediateDirectories: false, attributes: nil)
                }
                try bookData.write(to: subdirUrl.appendingPathComponent(bookURL.lastPathComponent, isDirectory: false), options: [])
                completion(true)
            } catch {
                print(error)
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }
}
