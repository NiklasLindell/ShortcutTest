import Foundation
import UIKit

class LightIntentHandler: NSObject, LightIntentHandling {
    
    
    func confirm(intent: LightIntent, completion: @escaping (LightIntentResponse) -> Void) {
        completion(LightIntentResponse(code: LightIntentResponseCode.ready, userActivity: nil))
    }
    
    
    public func handle(intent: LightIntent, completion: @escaping (LightIntentResponse) -> Void) {
        
        let devicesList = Shared.cache.devices

        for device in devicesList {
                device.isOn = false
        }
        completion(LightIntentResponse.successOff(lights: "light", off: "off"))
    }
}
