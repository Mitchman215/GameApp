//
//  Stack.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/10/22.
//

import Foundation

struct Stack<T> {
    
    private var data: [T] = []
    
    mutating func push(_ elt: T) {
        data.append(elt)
    }
    
    mutating func pop() -> T {
        data.removeLast()
    }
}
