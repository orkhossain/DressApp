//
//  OutfitStructure.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 16/01/2022.
//

import Foundation

struct Outfit: Identifiable,Decodable {
    
    var id : String
    var Clothing: [String:String]
    var Event: String
    var Gender: String
    var Season: String
    var Favourite: Bool
    

}
