class vector<T> {
    var data : [T] = []

    subscript(index:Int) -> T {
        get {
            print ("subscript get", index)
            return data[index]
        }
        set(newElm) {
            print ("subscript, set", index, newElm)
            data.insert(newElm, at: index)
        }
    }
}

class matrix<T> : vector<vector<T>> {
    var N: Int
    init(_ matrixDim: Int, _ initVal: T) {
        N = matrixDim
        super.init()
        for i in 0..<N {
            //data[i] = vector<T>()
            data.insert(vector<T>(), at: i)
            for j in 0..<N {
                data[i][j] = initVal
            }
        }
    }
}

var vFoo = vector<Any>()

vFoo[0] = "hello"
vFoo[1] = "world"
vFoo[2] = 2

print (vFoo[1])


var mFoo = matrix<Float>(3, 0.0)
mFoo[0][0] = 1.0
print(mFoo.data.count)

//print (mFoo[0][0])
