//
//  ChooseFileInteractor.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 12.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation
import JSQDataSourcesKit

protocol ChooseFileInteractorInput {

    func setFetchedResultsDelegate(_ request: ChooseFile.SetDelegate.Request)
    func configureFetchedResultsController(_ request: ChooseFile.Configure.Request)
    func fetchFiles(_ request: ChooseFile.FetchFiles.Request)

    var numberOfSelectedFiles: Int { get }
    func fileSelected(_ request: ChooseFile.SelectFiles.Request)
    func fileDeselected(_ request: ChooseFile.SelectFiles.Request)

    var chosenFiles: [File] { get }
    var encryption: Bool { get set }
}

protocol ChooseFileInteractorOutput {
    func presentFiles(_ response: ChooseFile.Configure.Response)
}

class ChooseFileInteractor: ChooseFileInteractorInput {

    var output: ChooseFileInteractorOutput!
    var worker: ChooseFileWorker!

    private var fetchedResultsController: FetchedResultsController<ManagedFile>!
    private var selectedFiles = Set<IndexPath>()
    var numberOfSelectedFiles: Int { return selectedFiles.count }
    var encryption = true

    // MARK: - Business logic

    func setFetchedResultsDelegate(_ request: ChooseFile.SetDelegate.Request) {
        fetchedResultsController.delegate = request.fetchedResultsControllerDelegate
    }

    func configureFetchedResultsController(_ request: ChooseFile.Configure.Request) {

        worker = ChooseFileWorker()
        let fetchedResultsController = worker.createFetchedResultsController(
            forEncryptedFiles: !request.forEncryption
        )

        self.fetchedResultsController = fetchedResultsController
        let response = ChooseFile.Configure.Response(fetchedResultsController: fetchedResultsController)

        output.presentFiles(response)
    }

    func fetchFiles(_ request: ChooseFile.FetchFiles.Request) {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Fetch error = \(error)")
        }
    }

    func fileSelected(_ request: ChooseFile.SelectFiles.Request) {
        selectedFiles.insert(request.indexPath)
    }

    func fileDeselected(_ request: ChooseFile.SelectFiles.Request) {
        selectedFiles.remove(request.indexPath)
    }

    var chosenFiles: [File] {
        return selectedFiles.map { File(fetchedResultsController[$0]) }
    }

}
