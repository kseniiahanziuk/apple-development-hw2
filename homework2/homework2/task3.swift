import Foundation

class MyData {
    private class Storage {
        var data: [Int]

        init(data: [Int]) {
            self.data = data
        }
    }

    private var storage: Storage

    init(data: [Int]) {
        self.storage = Storage(data: data)
    }

    private init(storage: Storage) {
        self.storage = storage
    }

    func copy() -> MyData {
        return MyData(storage: self.storage)
    }

    var data: [Int] {
        get {
            return storage.data
        }
        set {
            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(data: storage.data)
            }
            storage.data = newValue
        }
    }

    func modify(at index: Int, with value: Int) {
        if !isKnownUniquelyReferenced(&storage) {
            storage = Storage(data: storage.data)
        }
        storage.data[index] = value
    }
}

func executionTask3() {
    print("Task 3.")
    let initialData = MyData(data: [10, 49, 31, 100])
    let copiedData = initialData.copy()

    copiedData.modify(at: 0, with: 48)
    copiedData.modify(at: 2, with: 50)

    print("Initial array: ", initialData.data)
    print("CoW array: ", copiedData.data)
    print("\n")
}

// The output:
// Original array:  [10, 49, 31, 100]
// CoW array:  [48, 49, 50, 100]
