//
//  UserDefaults.swift
//  miniMusic
//
//  Created by Mark Goncharov on 12.08.2022.
//

import UIKit

extension UserDefaults {
    
    static let favouriteTrackKey = "favouriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        
        let defaults = UserDefaults.standard

        guard let savedTracks = defaults.object(forKey: UserDefaults.favouriteTrackKey)
                                                                as? Data else { return [] }
        guard let decodeTracks = try?
                NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks)
                                                                as? [SearchViewModel.Cell] else { return [] }
        return decodeTracks
                                                                    
    }
    
}
