import Foundation

class MatrixCreator {
    var array: [[Float]] = [[Float]]()
    var size: Int

    func getArray() -> [[Float]] {
        return array
    }

    init(_ sizeIn: Int) {
        size = sizeIn

        populateArray(sizeIn, 0)
    }

    func populateArray(_ size: Int, _ num: Float) {
        var arrayIn: [Float] = [Float]()

        for i in 0..<size {
            arrayIn.append(num)
        }

        for i in 0..<size {
            array.append(arrayIn)
        }
    }
}

func doProgram() {
    var doEquationGet = true

    var matrixnum: Int = Int(readLine()!)!

    var mcreator: MatrixCreator = MatrixCreator(matrixnum)

    var array: [[Float]] = mcreator.getArray()

    if(matrixnum < 1) {
        return
    }

    if(matrixnum == 1) {
        doEquationGet = false
    }

    for i in 0..<matrixnum {
        for j in 0..<matrixnum {
            array[i][j] = Float(readLine()!)!
        }
    }

    while(doEquationGet) {
        var pivot = 0
        print("Input Matrix is:")
        for i in 0..<matrixnum {
            print(array[i])
        }
        for j in 0..<matrixnum-1 {
            for i in pivot+1..<matrixnum {    
               // print(i)
                let subTimes: Float = Float(array[i][pivot]/array[pivot][pivot])

               // print(subTimes)
                array = applyMatrixSubtract(array: array, rowToSub: pivot, subTimes: subTimes, subFrom: i)
            }
            pivot=pivot+1
        }
        print("Output Matrix is:")
        for i in 0..<matrixnum {
            print(array[i])
        }
        break
        for i in 1...matrixnum-1 {
            for j in 0...i-1 {
                let k = array[i][j]
                if(k==0) {
                    doEquationGet=false
                }else{
                    doEquationGet = true
                    break
                }
            }
        }
        if(!doEquationGet) {
            print(array)
        }
    }
}

func applyMatrixSubtract( array: [[Float]], rowToSub: Int, subTimes: Float, subFrom: Int) -> [[Float]]{
    var newArray = array

    var newRow: [Float] = [Float]()
    for j in 0..<newArray[subFrom].count {
        newRow.append(newArray[subFrom][j]-newArray[rowToSub][j]*subTimes)
    }
    newArray[subFrom] = newRow

    return newArray
}

doProgram()



