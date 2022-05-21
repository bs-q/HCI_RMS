import Foundation

/**
 Ref:
    + https://viblo.asia/p/tim-hieu-ve-property-wrapper-trong-swift-djeZ1P1QKWz
 Used:
    @UserDefault(key: "isPaymentEnabled", initialValue: false) var paymentEnabled: Bool
 */

@propertyWrapper
struct AppUserDefault<Value> {
    var key: String
    var defaultValue: Value
    var wrappedValue: Value? {
        set {
            if(newValue == nil){
                UserDefaults.standard.removeObject(forKey: key)
                UserDefaults.standard.synchronize();
            }else{
                UserDefaults.standard.set(newValue, forKey: key)
                UserDefaults.standard.synchronize();
            }
            
        }
        get {
            UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        }
    }
}
