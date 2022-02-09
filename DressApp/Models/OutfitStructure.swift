//
//  OutfitStructure.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 16/01/2022.
//

import Foundation

struct Outfit: Identifiable {
    
    var id : String
    var Description: String
    var Item: [Clothing]
    var Event: String
    var Gender: String
    var Season: String
    var Favourite: Bool
    

}