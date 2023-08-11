//
//  main.swift
//  Tomato Farm
//
//  Created by Alireza Karimi on 2023-08-11.
//
//  helped by chatgpt

import Foundation

struct Queue<T> {
    private var array: [T] = []
    
    mutating func enqueue(item: T) {
        array.append(item)
    }
    
    mutating func dequeue() -> T? {
        return array.isEmpty ? nil : array.removeFirst()
    }
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
}

func shortestBridgeLength() {
    let n = Int(readLine()!)!
    
    var grid = [[Int]]()
    for _ in 0..<n {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        grid.append(row)
    }
    
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]
    
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
    var queue = Queue<(Int, Int)>()
    
    // Find the first island and mark its cells as visited
    var found = false
    for i in 0..<n {
        if found {
            break
        }
        for j in 0..<n {
            if grid[i][j] == 1 {
                queue.enqueue(item: (i, j))
                visited[i][j] = true
                found = true
                break
            }
        }
    }
    
    var bridgeLength = 0
    
    // BFS to expand the island and find the shortest bridge to the second island
    while !queue.isEmpty() {
        let size = queue.count
        for _ in 0..<size {
            let (x, y) = queue.dequeue()!
            for dir in 0..<4 {
                let nx = x + dx[dir]
                let ny = y + dy[dir]
                if nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny] {
                    if grid[nx][ny] == 1 {
                        print(bridgeLength)
                        return
                    }
                    queue.enqueue(item: (nx, ny))
                    visited[nx][ny] = true
                }
            }
        }
        bridgeLength += 1
    }
}

shortestBridgeLength()
