//
//  Todo.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 09/11/2021.
//

import Foundation


struct Clothing: Identifiable,Decodable {
    
    var id : String
    var Object: String
    var Description: String
    var Item: String
    var Colour: String
    var Event: String
    var Weather: String
    var Gender: String
    var Season: String
    var Favourite: Bool
    var Image: String
    

}
