//
//  Line.swift
//  TouchTracker
//
//  Created by WON on 09/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import Foundation
import CoreGraphics

struct Line {
    var begin = CGPoint.zero
    var end = CGPoint.zero

    var len: CGFloat {
        return sqrt(pow(abs(begin.x - end.x), 2) + pow(abs(begin.y - end.y), 2))
    }

    var angle: CGFloat {
        return  abs(begin.x - end.x) / len
    }
}
