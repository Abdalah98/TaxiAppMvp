//
//  GFError.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/17/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import Foundation
enum ResoneError :String,Error{
    case invaldURL               = "This URL invalid request."
    case invaldError             = "This URL Error Domain. Please check it and try again."
    case unableToComplete        = "Unable to complete your request. Please check your internet connection"
    case invalidResponse         = "Invalid response from the server. Please try again."
    case invalidData             = "The data received from the server was invalid. Please try again."
    case unableToFavorite        = "There was an error favoriting this new . please try again."
    case alreadyInFavorites      = "You `ve already favorited this new. you must REALLY Like them!"
}
