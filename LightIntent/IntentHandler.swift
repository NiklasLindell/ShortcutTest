import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is LightIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        return LightIntentHandler()
    }
}
