//
//  FactoryPattern.swift
//  oop_design_pattern
//
//  Created by Greem on 4/5/25.
//

import Foundation

enum Create { }

protocol Shape {
    func draw()
}

extension Create {
    final class ShapeFactory {
        enum ShapeType {
            case circle
            case square
            case rectangle
        }
        func getShape(type: ShapeType) -> Shape {
            switch type {
            case .circle: Circle()
            case .rectangle: Rectangle()
            case .square: Square()
            }
        }
    }
    class Circle: Shape {
        init() { }
        func draw() { }
    }
    class Rectangle: Shape {
        init() { }
        func draw() { }
    }
    class Square: Shape {
        init() { }
        func draw() { }
    }
    
}
