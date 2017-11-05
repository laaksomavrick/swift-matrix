//
//  Matrix.swift
//  SwiftMatrix
//
//  Created by Mavrick Laakso on 2017-11-04.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//

import Foundation
import Darwin.ncurses

struct MatrixService {
    
    var matrix = [[Int32]]()
    
    init(columns: Int32, rows: Int32) {
        
        let columns = Int(columns)
        let rows = Int(rows)
        
        for column in 0 ..< columns {
            
            var col = [Int32]()
            
            for row in 0 ..< rows {
                col.append(64)
            }
            
            matrix.append(col)
        }
        
    }
    
}

extension MatrixService {
    
    func draw() {
        
        let columns = matrix.count - 1
        let rows = matrix[0].count - 1
        
        for i in 0 ..< columns {

            let x = Int32(i)
            move(0, x)
            
            let uint = UInt32(x)
            addch(uint)

            for j in 0 ..< rows {

                let y = Int32(j)
                move(y, x)

                let uint = UInt32(matrix[i][j])
                addch(uint)

            }

        }
        
    }
    
    func debug() {
        
    }
    
}
