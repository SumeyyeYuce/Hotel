//
//  SelectRoomTypeTableViewController.swift
//  HotelCalifornia
//
//  Created by Sümeyye on 21.02.2023.
//

import UIKit

//Design Pattern
protocol SelectRoomTypeTableViewControllerDelegate:class {//Bu protokol sadece class türündeki yapılarda implemmte ediliyor.
    func didSelect(roomType:RoomType)//Bu fonksiyon ile Yeni bir rromType seçilmiş onu anlicaz
    
}

class SelectRoomTypeTableViewController: UITableViewController {

    //MARK: - Elements
    
    //MARK: - Properties
    
    var selectedRoomType: RoomType?//Optinals olmasının nedeni henüz seçili bir oda yok ondan.
    weak var delegate:SelectRoomTypeTableViewControllerDelegate?//delegate bir önceki sayfanın referansı
    //Bir önceki sayfaya refeerans kurmak istediğimiz için,iki sayfa arasında kuvvetli bir ilişkinin önüne geçiyoruz weak kullanarak
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: - Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell")!
        let roomType = RoomType.all[indexPath.row]//O an çizilmekte olan roomType'ı verir.
        
        cell.textLabel?.text = roomType.name//sag taraftaki label
        cell.detailTextLabel?.text = "₺ \(roomType.price)"
        
        if roomType == selectedRoomType{ //EquTable protoklü == saglıyor.
            //O an çizilmekte olan oda türü, önceden seçilen oda türü mü?
            cell.accessoryType = .checkmark//accessoryType bununla önceden tanımlanmış aksesuarlar verebiliyoruz.
        }else{//Seçilmekte olan bişey yoksa hiçbişey çizmesin
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Seçili satırın seçili olma durumundan çıkması.
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRoomType = RoomType.all[indexPath.row]//RoomType'ın all ının seçili olan indexPath.row uncu elemanına eşitledik.
        delegate?.didSelect(roomType: selectedRoomType!)//delegate üzüerinde bir sinyal gönderiyoruz yani bir oda seçildi diyoruz.
        tableView.reloadData()//Tüm verileri yenidenn yüklemek.
    }
    //MARK: - Actions

   
}
