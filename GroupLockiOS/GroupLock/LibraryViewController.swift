//
//  LibraryViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 26.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import CoreData

class LibraryViewController: UITableViewController {
    
    private var folders = [Folder]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        let folderFetchRequest = NSFetchRequest(entityName: "Folder")
        do {
            folders = try managedObjectContext?.executeFetchRequest(folderFetchRequest) as! [Folder]
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("folderCell", forIndexPath: indexPath) as! FolderTableViewCell
        cell.title.text = folders[indexPath.row].name
        

        return cell
    }
 


}
