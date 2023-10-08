//
//  DataResponse.swift
//  Marvel
//
//  Created by Rafael González on 06/10/23.
//

import Foundation

struct DataResponse<T : Codable> : Codable{
    let offset : Int
    let limit : Int
    let total : Int
    let count : Int
    let results : [T]

}
