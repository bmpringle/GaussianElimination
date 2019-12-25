//
//  main.swift
//  MatrixMultiply
//
//  Created by Benjamin M. Pringle on 12/24/19.
//  Copyright © 2019 Benjamin M. Pringle. All rights reserved.
//

import Foundation

//Gets suffix for num
class NumToString {
    static func val(_ key: Int) -> String {
        switch(key) {
            case 1:
                return "1st"
            case 2:
                return "2nd"
            case 3:
                return "3rd"
            case 0:
                return "0th"
            case -1:
                return "-1st"
            case -2:
                return "-2nd"
            case -3:
                return "-3rd"
            default:
                return "\(key)th"
        }
    }
}

class UnwrappedLine {
    static func getLine() -> String {
        var wrapped = false
        var str: String = ""
        while(!wrapped) {
            let r = readLine()
            if(r != "") {
                wrapped = true
                str = r!
            }else{
                print("Please enter something:")
            }
        }
        return str
    }
}

class UnwrapTo {
    static func float(_ str: String) -> Float {
        while(true) {
            if(Float(str) != nil) {
                return Float(str)!
            }else{
                print("Please enter a valid number:")
                return self.float(UnwrappedLine.getLine())
            }
        }
    }
    
    static func int(_ str: String) -> Int {
        while(true) {
            if(Int(str) != nil) {
                return Int(str)!
            }else{
                print("Please enter a valid number:")
                return self.int(UnwrappedLine.getLine())
            }
        }
    }
}

/*
 Matrix Coordinate System works like so:
        5   1   6
        4   0   3
        2   4   1
 
 To get the top-left 5, use 1, 1
 To get the bottom-right 1, use 3, 3
 
  */

class SquareMatrix {
    var length: Int
    
    var Matrix: [[Float]] = [[Float]]()
    
    init(_ length: Int) {
        self.length = length
        setupMatrix()
    }
    
    func MatrixCount() -> Int {
        return Matrix.count
    }
    
    func getRawMatrix() -> [[Float]] {
        return Matrix
    }
    
    func getMatrixRow(_ row: Int) -> [Float]? {
        if(row <= length) {
            return Matrix[row-1]
        }else{
            print("Invalid Operation, row was out of matrix bounds.")
        }
        return nil
    }
    
    func getMatrixColumn(_ column: Int) -> [Float]? {
        if(column <= length) {
            var MatrixColumn = [Float]()
            
            for i in 0..<length {
                MatrixColumn.append(Matrix[i][column-1])
            }
            return MatrixColumn
        }else{
            print("Invalid Operation, column was out of matrix bounds.")
        }
        return nil
    }
    
    func printMatrix() {
        for i in 0..<length {
            print(Matrix[i])
        }
    }
    
    func changeEntry(_ x: Int, _ y: Int, _ changeTo: Float) {
        if(x<=length && y<=length) {
            Matrix[x-1][y-1] = changeTo
        }else{
            print("Invalid Operation, either x or y coord was out of matrix bounds.")
        }
    }
    
    func setupMatrix() {
        
        for i in 0..<length {
            
            var MatrixRow: [Float] = [Float]()
            
            for j in 0..<length {
                print("Please input the \(NumToString.val(j+1)) number in the \(NumToString.val(i+1)) row of the matrix:")
                MatrixRow.append(UnwrapTo.float(UnwrappedLine.getLine()))
            }
            Matrix.append(MatrixRow)
        }
    }
    
}

print("What is the Matrix's Length:")
var Matrix = SquareMatrix(UnwrapTo.int(UnwrappedLine.getLine()))

print("OG Matrix")
Matrix.printMatrix()

Matrix.changeEntry(2, 2, 6)

print("Matrix with 6 at 2, 2")
Matrix.printMatrix()

print("Matrix 2nd row")
print(Matrix.getMatrixRow(2)!)

print("Matrix 1st column")
print(Matrix.getMatrixColumn(1)!)








