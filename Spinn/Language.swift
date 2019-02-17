//
//  Language.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-17.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import Foundation

enum Language: Equatable {
    case english
    case svenska


}


extension Language {
    
    var code: String {
        switch self {
        case .english:               return "en"

        case .svenska:               return "sv"

        }
    }
    
    var name: String {
        switch self {
        case .english:                  return "English"
            
        case .svenska:               return "Svenska"
        }
    }
}

extension Language {
    
    init?(languageCode: String?) {
        guard let languageCode = languageCode else { return nil }
        switch languageCode {
        case "en":              self = .english
        case "sv":              self = .svenska
        default:                return nil
        }
    }
}
