//
//  CellController.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 11/04/26.
//

import UIKit

public struct CellController {
    let dataSoruce: UITableViewDataSource
    let delegate: UITableViewDelegate?
    let dataSourcePrefetching: UITableViewDataSourcePrefetching?
    
    public init(_ dataSoruce: UITableViewDataSource & UITableViewDelegate & UITableViewDataSourcePrefetching) {
        self.dataSoruce = dataSoruce
        self.delegate = dataSoruce
        self.dataSourcePrefetching = dataSoruce
    }
    
    public init(_ dataSoruce: UITableViewDataSource) {
        self.dataSoruce = dataSoruce
        self.delegate = nil
        self.dataSourcePrefetching = nil
    }
}
