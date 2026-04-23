//
//  CellController.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 11/04/26.
//

import UIKit

public struct CellController {
    let id: AnyHashable
    let dataSoruce: UITableViewDataSource
    let delegate: UITableViewDelegate?
    let dataSourcePrefetching: UITableViewDataSourcePrefetching?
    
    public init(id: AnyHashable, _ dataSoruce: UITableViewDataSource & UITableViewDelegate & UITableViewDataSourcePrefetching) {
        self.id = id
        self.dataSoruce = dataSoruce
        self.delegate = dataSoruce
        self.dataSourcePrefetching = dataSoruce
    }
    
    public init(id: AnyHashable, _ dataSoruce: UITableViewDataSource) {
        self.id = id
        self.dataSoruce = dataSoruce
        self.delegate = nil
        self.dataSourcePrefetching = nil
    }
}

extension CellController: Equatable {
    public static func == (lhs: CellController, rhs: CellController) -> Bool {
        lhs.id == rhs.id
    }
}

extension CellController: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
