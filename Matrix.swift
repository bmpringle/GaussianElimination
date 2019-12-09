class vector<T> {
    var data : [T] = []

    subscript(index:Int) -> T {
        get {
            //print ("subscript get", index)
            return data[index]
        }
        set(newElm) {
            //print ("subscript, set", index, newElm)
            if (index == data.count) {
                data.insert(newElm, at: index)
            } else {
                data[index] = newElm // overwrite existing elements
            }
        }
    }
    func dump( ) {
        print (data)
    }
}

class matrix<T> : vector<vector<T>> {
    var N: Int
    init(_ matrixDim: Int, _ initVal: T) {
        N = matrixDim
        super.init()
        for i in 0..<N {
            //data[i] = vector<T>()
            data.insert(vector<T>(), at: i) // not sure why the commented line above this should work
            for j in 0..<N {
                data[i][j] = initVal
            }
        }
    }
    override func dump() {
        for i in 0..<data.count {
            data[i].dump()
        }
    }
}

var vFoo = vector<Any>()

vFoo[0] = "hello"
vFoo[1] = "world"
vFoo[2] = 2

//print (vFoo[1])
vFoo.dump()

var mFoo = matrix<Float>(3, 0.0)
mFoo[0][0] = 1.0; mFoo[1][1] = 1.0; mFoo[2][2] = 1.0
print(mFoo.data.count)
print (mFoo[0][0])
mFoo.dump()
