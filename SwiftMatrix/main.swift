//
//  main.swift
//  SwiftMatrix
//
//  Created by Mavrick Laakso on 2017-11-04.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//

import Foundation
import Darwin.ncurses

initscr()                   // Init window. Must be first
cbreak()
noecho()                    // Don't echo user input
nonl()                      // Disable newline mode
intrflush(stdscr, true)     // Prevent flush
keypad(stdscr, true)        // Enable function and arrow keys
curs_set(1)                 // Set cursor to invisible

addch(0)
move(5, 0)
addch(1)
move(5, 5)
addch(2)
refresh()


// Wait for user input
// Exit on 'q'
while true {
    
    switch getch() {
        
    case Int32(UnicodeScalar("q").value):
        endwin()
        exit(EX_OK)
    default: true
    }
    
}
