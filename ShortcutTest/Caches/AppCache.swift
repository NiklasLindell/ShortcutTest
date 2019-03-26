import Foundation

protocol Cache {
    var lightState: [String : Bool] {get set}
}

private struct CacheKeys {
    static let LightStateKey = "light_state_key"
}

extension UserDefaults: Cache {
    var lightState: [String : Bool] {
        get {
            return dictionary(forKey: CacheKeys.LightStateKey) as! [String : Bool]
        }
        set {
            set(newValue, forKey: CacheKeys.LightStateKey)
        }
    }
    
    
//    var lightState: Bool {
//
//        get { return bool(forKey: CacheKeys.LightStateKey) }
//        set { newValue ? set(newValue, forKey: CacheKeys.LightStateKey) : removeObject(forKey: CacheKeys.LightStateKey)}
//    }
}
