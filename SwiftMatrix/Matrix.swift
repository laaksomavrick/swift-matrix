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
    
    let STREAM_LENGTH = 5
    
    var grid = [[Int32]]()
    var columns: Int = 0
    var rows: Int = 0
    
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
        }
        
    }
    
}

extension Matrix {
    
    func animate() {
        self.update()
        self.draw()
        napms(200)
    }
    
    func update() {
        
        //for i in 0 ..< columns {
            update_column(0)
        //}
        
    
    }
    
    private func update_column(_ column: Int) {
        
        clear_old_stream(column)
        check_and_restart_stream()
        draw_new_stream(column)
        update_base_and_offset_on_tick()
        
    }
    
    private func clear_old_stream(_ column: Int) {
        //out of bounds before sequence
        let before_base = base - 1
        if before_base >= 0 {
            grid[column][before_base] = Int32(UnicodeScalar(" ").value)
        }
    }
    
    private func check_and_restart_stream() {
        //restart when it hits bottom
        if base >= rows {
            reset_base_and_offset()
        }
    }
    
    private func draw_new_stream(_ column: Int) {
        for i in base ..< offset {
            if i >= rows { continue }
            grid[column][i] = Int32(UnicodeScalar("A").value)//Int32(arc4random_uniform(300))
        }
    }
    
    private func update_base_and_offset_on_tick() {
        if offset < STREAM_LENGTH {
            offset += 1
        } else {
            base += 1
            set_offset_relative_to_base()
        }
    }
    
    private func set_offset_relative_to_base() {
        offset = base + STREAM_LENGTH
    }
    
    private func reset_base_and_offset() {
        base = 0
        offset = 1
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
