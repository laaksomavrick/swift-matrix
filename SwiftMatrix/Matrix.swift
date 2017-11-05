//
//  Matrix.swift
//  SwiftMatrix
//
//  Created by Mavrick Laakso on 2017-11-04.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//

import Foundation
import Darwin.ncurses

class Matrix {
    
    var grid = [[Int32]]()
    var columns: Int = 0
    var rows: Int = 0
    var timer: Timer?
    
    init(columns: Int32, rows: Int32) {
        
        self.columns = Int(columns)
        self.rows = Int(rows)
        
        for column in 0 ..< self.columns {
            
            var row = [Int32]()
            
            for _ in 0 ..< self.rows {
                
                if column == 4 {
                    row.append(Int32(UnicodeScalar("a").value))
                } else {
                    row.append(Int32(UnicodeScalar(" ").value))
                }
                
            }
            
            grid.append(row)
        }
        
    }
    
}

extension Matrix {
    
    func animate() {
        
            self.update()
            self.draw()
            napms(250)
        
    }
    
    func update() {
        
        let random = arc4random_uniform(100)
        let random2 = arc4random_uniform(300)
        self.grid[10][4] = Int32(random)
        self.grid[10][10] = Int32(random2)
        self.grid[10][16] = Int32(random)
    
    }

    func draw() {
        
        for i in 0 ..< self.columns {

            let x = Int32(i)
            move(0, x)
            
            let uint = UInt32(x)
            addch(uint)

            for j in 0 ..< self.rows {

                let y = Int32(j)
                move(y, x)

                let uint = UInt32(grid[i][j])
                addch(uint)

            }

        }
        
    }
    
    func debug() {
        
    }
    
}
