import Foundation

class Node {
    var value: Int
    var children: [Node]
    var neighbors: [() -> Node?]

    init(value: Int, children: [Node] = []) {
        self.value = value
        self.children = children
        self.neighbors = []
    }

    func addChild(_ node: Node) {
        children.append(node)
    }
    
    func addNeighbor(_ node: Node) {
        neighbors.append { [weak node] in node }
    }

    func getNeighbors() -> [Node] {
        return neighbors.compactMap { $0() }
    }
}

class Tree {
    var root: Node

    init(root: Node) {
        self.root = root
    }

    func depth(node: Node?) -> Int {
        if node == nil {
            return 0
        }
        if node!.children.isEmpty {
            return 1
        }
        return 1 + node!.children.map { depth(node: $0) }.max()!
    }

    func calculateDepth() -> Int {
        return depth(node: root)
    }
    
    func search(value: Int, node: Node?) -> Bool {
        if node!.value == value {
            return true
        }
        
        if node == nil {
            return false
        }

        for child in node!.children {
            if search(value: value, node: child) {
                return true
            }
        }
        
        return false
    }
}

func executionTask2() {
    print("Task 2.")
    let rootNode = Node(value: 15)

    let child1 = Node(value: 12)
    let child2 = Node(value: 3)

    rootNode.addChild(child1)
    rootNode.addChild(child2)

    let grandChild1 = Node(value: 4)
    child1.addChild(grandChild1)
    let grandChild2 = Node(value: 8)
    child1.addChild(grandChild2)
    let greatGrandChild1 = Node(value: 5)
    grandChild2.addChild(greatGrandChild1)
    let greatGrandChild2 = Node(value: 3)
    grandChild2.addChild(greatGrandChild2)
    let gggChild = Node(value: 1)
    greatGrandChild2.addChild(gggChild)
    
    let neighbor1 = Node(value: 10)
    let neighbor2 = Node(value: 2)
    let neighbor3 = Node(value: 6)

    gggChild.addNeighbor(neighbor1)
    gggChild.addNeighbor(neighbor3)
    neighbor2.addNeighbor(neighbor1)
    print("Neighbors of gggChild: \(gggChild.getNeighbors().map { $0.value })")
    print("Neighbor of neighbor2: \(neighbor2.getNeighbors().map { $0.value })")
    print("Neighbor of neighbor3: \(neighbor3.getNeighbors().map { $0.value })")
    
    print("\n")
}


// As it gives out an error when we try to create an array of weak references, I used an array of closures(found this method on StackOverflow, I wanted to see if there were any alternatives to creating extra classes or using Cocoa tricks :3 ) for the purpose of safely saving weak references in them. Also removed redundant output from previous homework.

// The output:
// Neighbors of gggChild: [10, 6]
// Neighbor of neighbor2: [10]
// Neighbor of neighbor3: []
