//
//  FileManager.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.04.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import CoreData
import Photos

/// FileManager object represents a singleton for imitating file system structure for Library.
class FileManager: NSObject {
    
    /// Provides a singleton object of a file manager.
    static let sharedInstance = FileManager()
    
    private override init() {}
    
    private var managedObjectContext: NSManagedObjectContext {
        return AppDelegate.sharedInstance.managedObjectContext
    }
    
    /**
     Executes a request for all the files contained in `directory` and returns an array of them.
     
     - parameter directory: The directory we want to get files contained in.
     
     - returns: An array of files.
     */
    func files(insideDirectory directory: Directory) -> [File] {
        let fetchRequest = NSFetchRequest(entityName: "File")
        switch directory {
        case .Encrypted:
            fetchRequest.predicate = NSPredicate(format: "encrypted == true")
        case .Decrypted:
            fetchRequest.predicate = NSPredicate(format: "encrypted == false")
        }
        do {
            let files = try managedObjectContext.executeFetchRequest(fetchRequest) as! [File]
            return files
        } catch {
            print(error)
            abort()
        }
    }
    
    func createFile(name: String, type: String, encrypted: Bool, contents: NSData?) -> File? {
        guard let entity = NSEntityDescription.entityForName("File",
                                                             inManagedObjectContext: managedObjectContext) else {
            return nil
        }
        
        let file = File(entity: entity, insertIntoManagedObjectContext: nil)
        file.name = name
        file.type = type
        file.encrypted = encrypted
        file.contents = contents
        return file
    }
    
    func createFileFromURL(url: NSURL, withName name: String, encrypted: Bool) -> File? {
        guard let fileType = url.pathExtension else {
            return nil
        }
        let data = getImageContentsForURL(url)
        return createFile(name, type: fileType, encrypted: encrypted, contents: data)
    }
    
    private func getImageContentsForURL(url: NSURL) -> NSData? {
        
        let fetchResult = PHAsset.fetchAssetsWithALAssetURLs([url], options: nil)
        if let asset = fetchResult.firstObject as? PHAsset {
            var data: NSData?
            let options = PHImageRequestOptions()
            options.synchronous = true
            PHImageManager.defaultManager().requestImageDataForAsset(asset, options: options, resultHandler: { (imageData, _, _, _) in
                data = imageData
            })
            return data
        }
        return nil
    }
}
