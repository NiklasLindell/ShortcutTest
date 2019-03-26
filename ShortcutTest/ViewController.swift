import UIKit
import Intents
import os.log

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var lampList : [String : Bool] = Shared.cache.lightState
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(lampList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        switchOutlet.isOn = Shared.cache.lightState
    }
    
    @IBAction func addLamp(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add lamp", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name..."
        }
        let addAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if alert.textFields?.first?.text != ""{
                let lamp = alert.textFields!.first!.text!
                self.lampList.updateValue(false, forKey: lamp)
                
                
//                self.defaults.set(self.lampList, forKey: "lampList")
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action) in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func switchTapped(_ sender: Any) {
        donateInteraction()
//        Shared.cache.lightState = switchOutlet.isOn
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return defaults.array(forKey: "lampList")?.count ?? 1
        return lampList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if lampList.count == 0 {
            
            cell.textLabel?.text = "No lamps added"
            
            
            return cell
        }
//        cell.textLabel?.text = lampList[indexPath.row] as? String
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 25)
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            lampList.remove(at: indexPath.row)
            self.defaults.set(self.lampList, forKey: "lampList")
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
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

