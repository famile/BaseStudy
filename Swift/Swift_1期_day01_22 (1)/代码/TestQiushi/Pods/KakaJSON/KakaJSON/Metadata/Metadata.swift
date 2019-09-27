//
//  Metadata.swift
//  KakaJSON
//
//  Created by MJ Lee on 2019/8/4.
//  Copyright © 2019 MJ Lee. All rights reserved.
//

public struct Metadata {
    // MARK: - Type
    private static let typeLock = NSRecursiveLock()
    private typealias TypeKey = UInt
    private static func typeKey(_ type: Any.Type) -> TypeKey {
        type ~>> TypeKey.self
    }
    private static var types = [TypeKey: BaseType]()
    
    public static func type(_ type: Any.Type) -> BaseType? {
        // get from cache
        let key = typeKey(type)
        if let mt = types[key] { return mt }
        
        // name
        let name = String(describing: type)
        if name == "Swift._SwiftObject" || name == "NSObject" { return nil }
        
        typeLock.lock()
        defer { typeLock.unlock() }
        // judge after lock
        if let mt = types[key] { return mt }
        
        // type judge
        var mtt: BaseType.Type
        let kind = Kind(type)
        switch kind {
        case .class: mtt = ClassType.self
        case .struct: mtt = StructType.self
        case .enum: mtt = EnumType.self
        case .optional: mtt = OptionalType.self
        case .objCClassWrapper: mtt = ObjCClassType.self
        case .foreignClass: mtt = ForeignClassType.self
        case .tuple: mtt = TupleType.self
        case .function: mtt = FunctionType.self
        case .existential: mtt = ProtocolType.self
        case .metatype: mtt = MetaType.self
        default: mtt = BaseType.self
        }
        
        // ceate and put it into cache
        let mt = mtt.init(name: name, type: type, kind: kind)
        types[key] = mt
        return mt
    }
    
    public static func type(_ obj: Any) -> BaseType? {
        type(Swift.type(of: obj))
    }
}
