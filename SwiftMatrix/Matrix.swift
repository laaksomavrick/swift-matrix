//
//  Matrix.swift
//  SwiftMatrix
//
//  Created by Mavrick Laakso on 2017-11-04.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//

import Foundation
import Darwin.ncurses

typealias Stream = (base: Int, offset: Int, length: Int, active: Bool)

class Matrix {
    
    var grid = [[Int32]]()
    var streams = [Stream]()
    var columns: Int = 0
    var rows: Int = 0
    
    //every column needs a base and offset
    var base = 0
    var offset = 1
    
    init(columns: Int32, rows: Int32) {
        
        self.columns = Int(columns)
        self.rows = Int(rows)
        
        for _ in 0 ..< self.columns {
            
            var row = [Int32]()
            
            for _ in 0 ..< self.rows {
                
                row.append(Int32(UnicodeScalar(" ").value))

            }
            
            grid.append(row)
            
            let default_stream = Stream(base: 0, offset: 0, length: random_length(), active: false)
            streams.append(default_stream)
            
        }
        
    }
    
}

extension Matrix {
    
    func animate() {
        self.update()
        self.draw()
        napms(100)
    }
    
    func update() {
        
        for i in 0 ..< columns {
            update_column(i)
        }
    
    }
    
    private func update_column(_ column: Int) {
        
        let active = streams[column].active
        
        if active {
            clear_old_stream(column)
            check_and_restart_stream(column)
            draw_new_stream(column)
            update_base_and_offset_on_tick(column)
        } else {
            randomly_activate(column)
        }
        
    }
    
    private func randomly_activate(_ column: Int) {
        let random = arc4random_uniform(1000)
        if random < 35 {
            streams[column].active = true
        }
    }
    
    private func clear_old_stream(_ column: Int) {
        //out of bounds before sequence
        let base = streams[column].base
        let before_base = base - 1
        if before_base >= 0 {
            grid[column][before_base] = Int32(UnicodeScalar(" ").value)
        }
    }
    
    private func check_and_restart_stream(_ column: Int) {
        //restart when it hits bottom
        let base = streams[column].base
        if base >= rows {
            reset_base_and_offset(column)
        }
    }
    
    private func draw_new_stream(_ column: Int) {
        let base = streams[column].base
        let offset = streams[column].offset
        for i in base ..< offset {
            if i >= rows { continue }
            grid[column][i] = Int32(arc4random_uniform(300))
        }
    }
    
    private func update_base_and_offset_on_tick(_ column: Int) {
        if streams[column].offset < streams[column].length {
            streams[column].offset += 1
        } else {
            streams[column].base += 1
            set_offset_relative_to_base(column)
        }
    }
    
    private func set_offset_relative_to_base(_ column: Int) {
        streams[column].offset = streams[column].base + streams[column].length
    }
    
    private func reset_base_and_offset(_ column: Int) {
        streams[column].base = 0
        streams[column].offset = 0
        streams[column].length = random_length()
        streams[column].active = false
    }
    
    private func random_length() -> Int {
        let max: UInt32 = UInt32((Double(columns) * 0.2).rounded(.down))
        let min: UInt32 = UInt32((Double(columns) * 0.05).rounded(.down))
        return Int(arc4random_uniform(max) + min)
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
    
}
