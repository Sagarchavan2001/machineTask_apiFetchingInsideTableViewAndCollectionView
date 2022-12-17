//
//  userModel.swift
//  apiFetchingInCollectionViewAndTableView
//
//  Created by STC on 17/12/22.
//

import Foundation
struct apiResponce2: Decodable{
    var name : Name
    
}
struct Name : Decodable{
    var firstname : String
    var lastname : String
}
