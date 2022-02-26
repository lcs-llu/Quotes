//
//  SharedFunctionsAndConstants.swift
//  Quotes
//
//  Created by Leo Lu on 2022-02-26.
//

import Foundation

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

let savedFavouritesLabel = "savedFavourites"
