//
//  Data.swift
//  Task_Sep17
//
//  Created by L-156157182 on 18/09/18.
//

import Foundation
class DataModel {
    let title: String?
    let description: String?
    let url: String?
    var navBarTitle: String?    

    init(title:String?, description:String?, url:String?, navBarTitle:String?) {
        self.title = title
        self.description = description
        self.url = url
        self.navBarTitle = navBarTitle
    }

}


