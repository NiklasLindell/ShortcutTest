import Foundation
import UIKit

class LightIntentHandler: NSObject, LightIntentHandling {
    
    func confirm(intent: LightIntent, completion: @escaping (LightIntentResponse) -> Void) {
        completion(LightIntentResponse(code: LightIntentResponseCode.ready, userActivity: nil))
    }
    
    
    public func handle(intent: LightIntent, completion: @escaping (LightIntentResponse) -> Void) {
        

        for lamp in Shared.cache.devices {
            if lamp.isOn == false {
                completion(LightIntentResponse.success(lights: "lights", on: "on"))
                lamp.isOn = true
            } else {
                completion(LightIntentResponse.successOff(lights: "lights", off: "off"))
                lamp.isOn = false
            }
        }
    }
}
