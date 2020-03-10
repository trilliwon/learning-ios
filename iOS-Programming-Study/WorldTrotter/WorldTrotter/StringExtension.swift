//
//  StringExtension.swift
//  WorldTrotter
//
//  Created by WON on 31/07/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
