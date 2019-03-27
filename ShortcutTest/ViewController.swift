import UIKit
import Intents
import os.log

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ALL DEVICES \(Shared.cache.devices)")
        
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
                Shared.cache.devices.append(Device(name: lamp, isOn: false))
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
        return Shared.cache.devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(Shared.cache.devices[indexPath.row].name) with state \(Shared.cache.devices[indexPath.row].isOn) "
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 25)
        cell.textLabel?.textColor = UIColor.white
        
        if Shared.cache.devices[indexPath.row].isOn == false {
            cell.backgroundColor = UIColor.clear
        } else {
            cell.backgroundColor = UIColor.green
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped at index \(indexPath.row) with state \(Shared.cache.devices[indexPath.row].isOn)")
        
        for lamp in Shared.cache.devices {
            if lamp.isOn == false {
                lamp.isOn = true
            } else {
                lamp.isOn = false
            }
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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

