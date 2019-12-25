//
//  main.swift
//  MatrixMultiply
//
//  Created by Benjamin M. Pringle on 12/24/19.
//  Copyright © 2019 Benjamin M. Pringle. All rights reserved.
//

import Foundation

typealias Scalar = Float80
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
    static func scalar(_ str: String) -> Scalar {
        while(true) {
            if(Scalar(str) != nil) {
                return Scalar(str)!
            }else{
                print("Please enter a valid number:")
                return self.scalar(UnwrappedLine.getLine())
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
    var operationNumberPerTriangle = 0
    var Matrix: [[Scalar]] = [[Scalar]]()
    var OriginalMatrix: [[Scalar]] = [[Scalar]]()
    init(_ length: Int) {
        self.length = length
        setupMatrix()
        OriginalMatrix=Matrix
        for i in 1..<length {
            operationNumberPerTriangle = operationNumberPerTriangle + length-i
        }
    }
    
    func getOperationsPerTriangle() -> Int {
        return operationNumberPerTriangle
    }
    
    func MatrixCount() -> Int {
        return Matrix.count
    }
    
    func getRawMatrix() -> [[Scalar]] {
        return Matrix
    }
    
    func getMatrixEntry(_ x: Int, _ y: Int) -> Scalar {
        return Matrix[y-1][x-1]
    }
    
    func getMatrixRow(_ row: Int) -> [Scalar]? {
        if(row <= length) {
            return Matrix[row-1]
        }else{
            print("Invalid Operation, row was out of matrix bounds.")
        }
        return nil
    }
    
    func getMatrixColumn(_ column: Int) -> [Scalar]? {
        if(column <= length) {
            var MatrixColumn = [Scalar]()
            
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
    
    func changeEntry(_ x: Int, _ y: Int, _ changeTo: Scalar) {
        if(x<=length && y<=length) {
            Matrix[x-1][y-1] = changeTo
        }else{
            print("Invalid Operation, either x or y coord was out of matrix bounds.")
        }
    }
    
    func changeRow(_ x: Int, _ changeTo: [Scalar]) {
        if(x<=length) {
            Matrix[x-1] = changeTo
        }else{
            print("Invalid Operation, x coord was out of matrix bounds.")
        }
    }
    
    func setupMatrix() {
        
        for i in 0..<length {
            
            var MatrixRow: [Scalar] = [Scalar]()
            
            for j in 0..<length {
                print("Please input the \(NumToString.val(j+1)) number in the \(NumToString.val(i+1)) row of the matrix:")
                MatrixRow.append(UnwrapTo.scalar(UnwrappedLine.getLine()))
            }
            Matrix.append(MatrixRow)
        }
    }
    
}

class Vector {
    var vector: [Scalar] = [Scalar]()
    var length: Int
    var OriginalVector: [Scalar] = [Scalar]()
    init(_ length: Int) {
        self.length = length
        setupVector()
        OriginalVector=vector
    }
    
    func VectorCount() -> Int {
        return vector.count
    }
    
    func getRawVector() -> [Scalar] {
        return vector
    }

    func getVectorEntry(_ x: Int) -> Scalar {
        return vector[x-1]
    }

    func printVector() {
        for i in 0..<length {
            print(vector[i])
        }
    }
    
    func changeEntry(_ x: Int, _ changeTo: Scalar) {
        if(x<=length) {
            vector[x-1] = changeTo
        }else{
            print("Invalid Operation, x coord was out of matrix bounds.")
        }
    }
    
    func setupVector() {
        
        for i in 0..<length {
            print("Please input the \(NumToString.val(i+1)) number in the vector:")
            vector.append(UnwrapTo.scalar(UnwrappedLine.getLine()))
        }
    }
}

print("What is the Matrix's Length:")
let len = UnwrapTo.int(UnwrappedLine.getLine())
var Matrix = SquareMatrix(len)

var vector = Vector(len)

/*print("Get 1, 2")
print(Matrix.getMatrixEntry(1, 2))

print("OG Matrix")
Matrix.printMatrix()

Matrix.changeEntry(2, 2, 6)

print("Matrix with 6 at 2, 2")
Matrix.printMatrix()

print("Matrix 2nd row")
print(Matrix.getMatrixRow(2)!)

print("Matrix 1st column")
print(Matrix.getMatrixColumn(1)!)

print("Number of operations to get bottom-left triangle of 0s")
print(Matrix.getOperationsPerTriangle())*/

print("Matrix + Vector Before Bottom-Left Operation")
print("     Matrix:")
Matrix.printMatrix()
print("     Vector:")
vector.printVector()

//Do Bottom-Left Operations
for i in 1...Matrix.length {
    if(i<Matrix.length) {
        for j in i+1...Matrix.length {
            let pivotCoords = i
            let pivotRow = Matrix.getMatrixRow(pivotCoords)!
            var rowToModify = Matrix.getMatrixRow(j)!
            
            let pivotVectorScalar = vector.getVectorEntry(pivotCoords)
            var vectorScalarToModify = vector.getVectorEntry(j)
            
            let pivot = Matrix.getMatrixEntry(pivotCoords, pivotCoords)
            let entryToCancel = Matrix.getMatrixEntry(pivotCoords, j)
            let multiple: Scalar = -entryToCancel/pivot
            
            vectorScalarToModify = vectorScalarToModify+pivotVectorScalar*multiple
            for k in 0..<rowToModify.count {
                rowToModify[k] = rowToModify[k]+pivotRow[k]*multiple
            }
            Matrix.changeRow(j, rowToModify)
            vector.changeEntry(j, vectorScalarToModify)
        }
    }else{
        
    }
}

print("Matrix + Vector After Bottom-Left Operation")
print("     Matrix:")
Matrix.printMatrix()
print("     Vector:")
vector.printVector()



var matrixRaw = Matrix.getRawMatrix()
var vectorRaw = vector.getRawVector()

var changedMatrix = matrixRaw
var changedVector = vectorRaw

for i in 0..<Matrix.length {
    for j in 0..<Matrix.length {
        changedMatrix[i][j] = matrixRaw[Matrix.length-1-i][Matrix.length-1-j]
    }
    changedVector[i] = vectorRaw[Matrix.length-1-i]
}

Matrix.Matrix = changedMatrix
vector.vector = changedVector
//Do Top-Right Operations
for i in 1...Matrix.length {
    if(i<Matrix.length) {
        for j in i+1...Matrix.length {
            let pivotCoords = i
            let pivotRow = Matrix.getMatrixRow(pivotCoords)!
            var rowToModify = Matrix.getMatrixRow(j)!
            
            let pivotVectorScalar = vector.getVectorEntry(pivotCoords)
            var vectorScalarToModify = vector.getVectorEntry(j)
            
            let pivot = Matrix.getMatrixEntry(pivotCoords, pivotCoords)
            let entryToCancel = Matrix.getMatrixEntry(pivotCoords, j)
            let multiple: Scalar = -entryToCancel/pivot
            
            vectorScalarToModify = vectorScalarToModify+pivotVectorScalar*multiple
            for k in 0..<rowToModify.count {
                rowToModify[k] = rowToModify[k]+pivotRow[k]*multiple
            }
            Matrix.changeRow(j, rowToModify)
            vector.changeEntry(j, vectorScalarToModify)
        }
    }else{
        
    }
}

var matrixRawBack = Matrix.getRawMatrix()
var vectorRawBack = vector.getRawVector()

var changedVectorBack = vectorRawBack
var changedMatrixBack = matrixRawBack

for i in 0..<Matrix.length {
    for j in 0..<Matrix.length {
        changedMatrixBack[i][j] = matrixRawBack[Matrix.length-1-i][Matrix.length-1-j]
    }
    changedVectorBack[i] = vectorRawBack[Matrix.length-1-i]
}

Matrix.Matrix = changedMatrixBack
vector.vector = changedVectorBack

print("Matrix + Vector After Top-Right Operation")
print("     Matrix:")
Matrix.printMatrix()
print("     Vector:")
vector.printVector()

//Divide out the coefficents to get the identity matrix
for i in 0..<Matrix.length {
    let pivot = Matrix.Matrix[i][i]
    let pivotVectorCorrespond = vector.vector[i]
    let newPivot = pivot/pivot
    let newPivotVectorCorrespond = pivotVectorCorrespond/pivot
    Matrix.Matrix[i][i] = newPivot
    vector.vector[i] = newPivotVectorCorrespond
}

print("Matrix + Vector After Coefficent Division")
print("     Matrix:")
Matrix.printMatrix()
print("     Vector:")
vector.printVector()

//Check if Elimination Worked
for i in 0..<Matrix.length {
    let Equation = Matrix.OriginalMatrix[i]
    var leftSide: Scalar = 0
    
    for j in 0..<Matrix.length {
        leftSide = leftSide + Equation[j]*vector.vector[j]
    }
    
    if(leftSide == vector.OriginalVector[i]) {
        print("Equation \(i+1) Works")
    }else{
        print("\(leftSide), the left Side, isn't equal to the right side \(vector.OriginalVector[i])")
        print("Equation \(i+1) Doesn't work")
        break
    }
}




