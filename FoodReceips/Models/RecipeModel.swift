//
//  RecipeModel.swift
//  FoodReceips
//
//  Created by Dilan Jayamanne on 2023-05-19.
//

import Foundation

struct Recipe: Identifiable{
    let id: UUID = UUID()
    let name: String
    let ingredients: [String]
    let imageURL: URL?
    let steps: [String]
    let difficulty: Difficulty
    let time: Int
}


enum Difficulty: String {
    case easy
    case medium
    case hard
}
