//
//  Ncurses.swift
//  SwiftMatrix
//
//  Created by Mavrick Laakso on 2017-11-04.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//

import Foundation
import Darwin.ncurses

func initialize() {
    initscr() // init window
    savetty() // save state of terminal
    nonl()    // no newline
    cbreak()  // disable line buffering
    noecho()  //
    timeout(0)
    leaveok(stdscr, true)
    curs_set(0)
    signal(SIGINT, exit)
    signal(SIGWINCH, refresh)
    
    refresh(SIGWINCH)
}
        
    
    
func start() {
    while true {
        
        switch getch() {
            
        case Int32(UnicodeScalar("q").value):
            endwin()
            Darwin.exit(EX_OK)
        default: true
        }
        
    }
}



func refresh(_ op: Int32) {
    
    endwin()
    refresh()
    clear()
    
    let matrix = Matrix(columns: COLS, rows: LINES)
    matrix.draw()
    
}

func exit(_ op: Int32) {
    
}

