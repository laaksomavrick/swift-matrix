//
//  Ncurses.swift
//  SwiftMatrix
//
//  Created by Mavrick Laakso on 2017-11-04.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//

import Foundation
import Darwin.ncurses

struct Ncurses {
    
    static func initialize() {
        initscr()                   // Init window. Must be first
        cbreak()
        noecho()                    // Don't echo user input
        nonl()                      // Disable newline mode
        intrflush(stdscr, true)     // Prevent flush
        keypad(stdscr, true)        // Enable function and arrow keys
        curs_set(1)                 // Set cursor to invisible
        
        
        let matrix = MatrixService(columns: COLS, rows: LINES)
        matrix.draw()
        
    }
    
    static func refresh() {
        
    }
    
    static func exit() {
        
    }
    
    static func start() {
        while true {
            
            switch getch() {
                
            case Int32(UnicodeScalar("q").value):
                endwin()
                Darwin.exit(EX_OK)
            default: true
            }
            
        }
    }
    
}
