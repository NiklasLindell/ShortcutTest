import IntentsUI
import AVFoundation
import os


class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureView(for parameters: Set<INParameter>,
                       of interaction: INInteraction,
                       interactiveBehavior: INUIInteractiveBehavior,
                       context: INUIHostedViewContext,
                       completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        
        guard interaction.intent is LightIntent else {
            completion(false, Set(), .zero)
            return
        }
        
        let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
        let desiredSize = CGSize(width: width, height: 300)
        
       
        completion(true, parameters, desiredSize)
    }
    
    
}
