import UIKit
import Intents
import os.log

class ViewController: UIViewController {

    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switchOutlet.isOn = Shared.cache.lightState
        print(Shared.cache.lightState)
    }
    
   
    
    
    @IBAction func switchTapped(_ sender: Any) {
        donateInteraction()
        Shared.cache.lightState = switchOutlet.isOn
        
    }
    
    
    func donateInteraction() {
        let intent = LightIntent()
        intent.suggestedInvocationPhrase = "light"
        intent.lights = "lights"
        intent.on = "on"
        intent.off = "off"
        
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.groupIdentifier = Constants.AppGroup
        interaction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: %@", error)
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
    }


}

