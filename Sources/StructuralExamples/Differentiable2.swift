// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import StructuralCore

/// A protocol similar to Differentiable in Differential Programming Manifesto.
protocol Differentiable2 {
    associatedtype TangentVector: Differentiable2
    where TangentVector.TangentVector == TangentVector

    mutating func move(along direction: TangentVector)
}

/// Differentiable pair of two values.
struct DifferentiableCons<Value, Next>: Differentiable2
where
    Value: Differentiable2,
    Value.TangentVector == Value,
    Next: Differentiable2,
    Next.TangentVector == Next
{
    typealias TangentVector = Self

    var value: Value
    var next: Next

    init(_ value: Value, _ next: Next) {
        self.value = value
        self.next = next
    }

    mutating func move(along direction: TangentVector) {
        self.value.move(along: direction.value)
        self.next.move(along: direction.next)
    }
}

/// Differentiable nullary tuple.
struct DifferentiableEmpty: Differentiable2 {
    typealias TangentVector = Self

    mutating func move(along direction: TangentVector) {}
}

/// A property wrapper that ignores the field from the point of
/// view of differentiable.
@propertyWrapper struct NoDerivative<T>: Differentiable2 {
    var wrappedValue: T

    init(wrappedValue: T) { self.wrappedValue = wrappedValue }

    typealias TangentVector = DifferentiableEmpty

    mutating func move(along direction: TangentVector) {}
}

// Inductive cases. 

extension StructuralCons: Differentiable2
where Value: Differentiable2, Next: Differentiable2 {
    typealias TangentVector = DifferentiableCons<Value.TangentVector, Next.TangentVector>

    mutating func move(along direction: TangentVector) {
        self.value.move(along: direction.value)
        self.next.move(along: direction.next)
    }
}

extension StructuralStruct: Differentiable2
where Properties: Differentiable2 {
    typealias TangentVector = Properties.TangentVector

    mutating func move(along direction: TangentVector) {
        self.properties.move(along: direction)
    }
}

extension StructuralProperty: Differentiable2
where Value: Differentiable2 {
    typealias TangentVector = Value.TangentVector

    mutating func move(along direction: TangentVector) {
        self.value.move(along: direction)
    }
}

extension StructuralEmpty: Differentiable2 {
    typealias TangentVector = DifferentiableEmpty

    mutating func move(along direction: TangentVector) {}
}

// Base cases.

extension Float: Differentiable2 {
    typealias TangentVector = Self

    mutating func move(along direction: TangentVector) {
        self += direction
    }
}

// Sugar

extension Differentiable2
where Self: Structural, Self.StructuralRepresentation: Differentiable2 {
    // Can't do that: 
    // typealias TangentVector = Self.StructuralRepresentation.TangentVector

    mutating func move(along direction: Self.StructuralRepresentation.TangentVector) {
        self.structuralRepresentation.move(along: direction)
    }
}
