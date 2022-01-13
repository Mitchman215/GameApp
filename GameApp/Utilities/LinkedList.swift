//
//  LinkedList.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/10/22.
//

import Foundation

indirect enum LinkedList<T> {
    case empty
    case node(first: T, rest: LinkedList<T>)
}
