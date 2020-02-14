import GenericCore

/// A duplicate, simplified version of the `Equatable` protocol.
/// - Note: a duplicate protocol is used to avoid triggering existing `Equatable` derived
///   conformances.
public protocol EquatableGeneric {
    func genericEqual(_ other: Self) -> Bool

}

// Inductive cases.

extension Case: EquatableGeneric where A: EquatableGeneric, B: EquatableGeneric {
    @inline(__always)
    public func genericEqual(_ other: Self) -> Bool {
        switch (self, other) {
        case let (.of(_, x), .of(_, y)):
            return x.genericEqual(y)
        case let (.next(x), .next(y)):
            return x.genericEqual(y)
        default:
            return false
        }
    }
}

extension Field: EquatableGeneric where A: EquatableGeneric, B: EquatableGeneric {
    @inline(__always)
    public func genericEqual(_ other: Self) -> Bool {
        return value.genericEqual(other.value) && next.genericEqual(other.next)
    }
}

extension Enum: EquatableGeneric where A: EquatableGeneric {
    @inline(__always)
    public func genericEqual(_ other: Self) -> Bool {
        shape.genericEqual(other.shape)
    }
}

extension Struct: EquatableGeneric where A: EquatableGeneric {
    @inline(__always)
    public func genericEqual(_ other: Self) -> Bool {
        shape.genericEqual(other.shape)
    }
}

// Base cases.

extension Empty: EquatableGeneric {
    @inline(__always)
    public func genericEqual(_ other: Empty) -> Bool {
        return true
    }
}

extension Int: EquatableGeneric {
    @inline(__always)
    public func genericEqual(_ other: Int) -> Bool {
        return self == other
    }
}

extension Float: EquatableGeneric {
    @inline(__always)
    public func genericEqual(_ other: Float) -> Bool {
        return self == other
    }
}

extension Double: EquatableGeneric {
    @inline(__always)
    public func genericEqual(_ other: Double) -> Bool {
        return self == other
    }
}
