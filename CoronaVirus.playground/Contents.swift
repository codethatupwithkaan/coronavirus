import UIKit
import PlaygroundSupport

// Corona Virus
//In a given grid, each cell can have one of three values:
//
//the value 0 representing an empty cell;
//the value 1 representing a fresh human (not-infected)
//the value 2 representing an infected human.
//Every minute, any fresh human that is adjacent (4-directionally) to an un-infected human becomes infected.
//
//Return the minimum number of minutes that must elapse until no cell has fresh humans.  If this is impossible, return -1 instead.

//Example 1:
let outbreak = UIImage(named: "outbreak.png")

// Min 0    Min 1   Min 2   Min 3   Min 4 (End)
// I H H    I I H   I I I   I I I   I I I
// H H _    I H _   I I _   I I _   I I _
// _ H H    _ H H   _ H H   _ I H   _ I I

//Input: [[2,1,1],[1,1,0],[0,1,1]]
//Output: 4

var input = [[2,1,1],[1,1,0],[0,1,1]]

func outbreakSpread(_ grid: [[Int]]) -> Int {
    let rows = grid.count, cols = grid[0].count
    guard rows != 0, cols != 0 else { return -1 }
    
    var healthy = 0 // Fresh human count
    var infected = [(Int, Int)]() // Array of Tuples that keeps track of indexes of infected humans
    var grid = grid // Mutable copy
    
    for row in 0..<rows {
        for col in 0..<cols {
            //If fresh human found
            if grid[row][col] == 1 {
                healthy += 1
            }
            //Else if infected found
            else if grid[row][col] == 2 {
                infected.append((row, col))
            }
        }
    }
    
    // If we have no fresh humans, we have nothing to infect. So we report that it'll take 0 minutes.
    if healthy == 0 { return 0 }
    
    var minutes = 0 // How long it'll take outbreak to spread
    
    while infected.count > 0, healthy > 0 {
        let count = infected.count
        minutes += 1
        
        for _ in 0..<count {
            // Let's get the first infected human and it's coordinate as a tuple
            let (row, col) = infected.removeFirst()
            
            // If fresh human to our left
            if row-1 >= 0, grid[row-1][col] == 1 {
                infected.append((row-1, col)) //Make it infected and add it to our list
                grid[row-1][col] = 0    //Update the grid to be empty
                healthy -= 1  //decrement healthy count
            }
            if row+1 < rows, grid[row+1][col] == 1 {
                infected.append((row+1, col))
                grid[row+1][col] = 0
                healthy -= 1
            }
            if col-1 >= 0, grid[row][col-1] == 1 {
                infected.append((row, col-1))
                grid[row][col-1] = 0
                healthy -= 1
            }
            if col+1 < cols, grid[row][col+1] == 1 {
                infected.append((row, col+1))
                grid[row][col+1] = 0
                healthy -= 1
            }
        }
    }
    
    return healthy == 0 ? minutes : -1
}

outbreakSpread(input)
