import Foundation
import UIKit

class LightIntentHandler: NSObject, LightIntentHandling {
    
    func confirm(intent: LightIntent, completion: @escaping (LightIntentResponse) -> Void) {
        completion(LightIntentResponse(code: LightIntentResponseCode.ready, userActivity: nil))
    }
    
    
    public func handle(intent: LightIntent, completion: @escaping (LightIntentResponse) -> Void) {
        
     
        if Shared.cache.lightState == true {
            completion(LightIntentResponse.successOff(lights: "lights", off: "off"))
            Shared.cache.lightState = false
            
        }
        if Shared.cache.lightState == false {
            completion(LightIntentResponse.success(lights: "lights", on: "on"))
            Shared.cache.lightState = true

        }
        else {
            completion(LightIntentResponse(code: .failure, userActivity: nil))
        }
    }
}
