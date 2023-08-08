//
//  RegistirationsTableViewController.swift
//  HotelCalifornia
//
//  Created by Sümeyye on 21.02.2023.
//

import UIKit

class RegistirationsTableViewController: UITableViewController {

    //MARK: - Elements
    
    //MARK: - Properties
    
    var registraiton = [Registiration]()//İçi boş bir Registiration array'i
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    //MARK: - Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registraiton.count//registraiton arrayinin count u kadar hücre olucak.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell")!
        let registration = registraiton[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = registration.fullName()
        
        let checkInString = dateFormatter.string(from: registration.checkInDate)
        let checkOutString = dateFormatter.string(from: registration.checkOutDate)
        let roomName = registration.roomType.name
        
        cell.detailTextLabel?.text = "\(checkInString) - \(checkOutString): \(roomName)"
        
        return cell
        
    }
    
    //MARK: - Actions

    @IBAction func unwindFromAddRegistration(unwindSegue:UIStoryboardSegue){
        //Geldiğim yer AddRegistirationTableViewController  mı?
        guard let source = unwindSegue.source as? AddRegistirationTableViewController,
              let registraion = source.registiration else{return}
        
        registraiton.append(registraion)
        tableView.reloadData()
    }
  

}
