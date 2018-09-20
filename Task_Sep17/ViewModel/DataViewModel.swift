//
//  DataViewModal.swift
//  Task_Sep17
//
//  Created by L-156157182 on 18/09/18.
//

import Foundation
class DataViewModel {
    let title: String?
    let description: String?
    let url: String?
    let navBarTitle: String?

    init(data :DataModel) {
        title = data.title
        description = data.description
        url = data.url
        navBarTitle = data.navBarTitle
    }
}
