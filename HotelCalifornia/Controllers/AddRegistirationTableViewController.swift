//
//  AddRegistirationTableViewController.swift
//  HotelCalifornia
//
//  Created by Sümeyye on 17.02.2023.
//

import UIKit

class AddRegistirationTableViewController: UITableViewController,SelectRoomTypeTableViewControllerDelegate {
  
    

    //MARK: - UI Elements
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel:UILabel!
    @IBOutlet var checkInDatePicker:UIDatePicker!
    @IBOutlet var checkOutDateLabel:UILabel!
    @IBOutlet var checkOutDatePicker:UIDatePicker!
    
    @IBOutlet var numberOfAdultsLabel:UILabel!
    @IBOutlet var numberOfAdultsStepper:UIStepper!
    @IBOutlet var numberOfChildernLabel:UILabel!
    @IBOutlet var numberOfChildrenStepper:UIStepper!
    
    @IBOutlet var wifiSwitch:UISwitch!
    
    @IBOutlet var roomTypeLabel:UILabel!
    
    
    //MARK: - Properties
    //DatePicker'ların kaçıncı IndexPath de olduklarını tuttuk.
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    //DatePicker başlangıçta gözüküp gözükmediğini kontrol ediyoruz.Başlangıç false
    var isCheckInDatePickerShown : Bool = false{
        didSet{//isCheckInDatePickerShown bunu ne zamann güncellersek didSet çalışıcak
            //isHidden:Bir arayüz elemanını  görünürlük bilgisi.
            checkInDatePicker.isHidden = !isCheckInDatePickerShown//tam tersi ise(checkInDatePicker ekranda gözükmesin dedik.)
            
        }
    }
    
 
    
    var isCheckOutDatePickerShown : Bool = false{
        didSet{
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var roomType:RoomType?//Başlangıçta seçili olmayan bir roomType
    
    var registiration : Registiration?{
        guard let roomType = roomType else{return nil}
        
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn //Açık mı
        
        //let roomChios = roomType?.name ?? "Not Set"//roomType nil değilse name'ini al.Nil se Not Set yazsın.
        
        //Registiration modeli oluşturuyoruz.
        return Registiration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, roomType: roomType, wifi: hasWifi)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CheckIn tarihini, bugunun gecesi olarak ayarlar.
        //Calendar.current:kullanıcının o anda bulundugu ülkeye göre olan doğru takvim demek
        //Calendar.current.startOfDay(for: Date()) ->Bulunduğumuz günün başlangıç saatinden itibaren alıyor.Örn:00:00 gibi
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday //Seçilebilicek en küçük tarihi ayarlar (gece 00:00)
        checkInDatePicker.date = midnightToday//checkInDatePicker 'in O an ki seçili tarihini ayarlar.
        
        updateDateViews()//uygulamayı açtoğımız günlerden başlasın dateler
        
        //StoryaBorad da ayarladığımız geçici degerleri, o anki stepper degeri ile günceller
        updateNumberOfGuests()
        
        updateRoomType()
    }

   
    
    //MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectRoomType"{
            let destination = segue.destination as? SelectRoomTypeTableViewController
            destination?.delegate = self//Gidiceğim sayfanın referansı bu sayfa olsun.
            destination?.selectedRoomType = roomType
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //heightForRowAt ->> Bu fonksiyon ekranda çizmekte oldugum hücre için
        //hangi yüksekliği kullanıym diye sorar
        
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown{
                return 210
            }else{
                return 0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown{
                return 210
            }else{
                return 0
            }
            
        default:
            //Picker hücreleri dışında kalan tüm hücrelerin yüksekliği
            return 44
                    
        }
      
    }
    //didSelectRowAt -> Üzerine tıklanıldığı bilgisi.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Seçili olan hücrenin, seçili olma durumunu sonlandırı.
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case checkInDateLabelCellIndexPath:
            if isCheckInDatePickerShown{
                isCheckInDatePickerShown = false
            }else if isCheckOutDatePickerShown{
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            }else{
                isCheckInDatePickerShown = true
            }
            //Değişkenlerdeki değişim ile, heightForRow fonksiyonunu tekrardan çalıştırılır.
            //Fakat yükseklik değişimleri animasyon ile saglanır.
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case checkOutDateLabelCellIndexPath:
            if isCheckOutDatePickerShown{
                isCheckOutDatePickerShown = false
            }else if isCheckInDatePickerShown{
                isCheckOutDatePickerShown = true
                isCheckInDatePickerShown = false
            }else{
                isCheckOutDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
        
    }
    func updateDateViews(){//Kullanıcı her değişiklik yaptıgında picker larda çalışıcak fonksiyon
        // 21/03/1996 -> .short -> 3:30 PM
        // 21/03/1996 -> .medium -> March 21, 1996
        
        //Otelimizde minimum 1 gece konaklama yapılacagı için,
        //checkOutDatePicker'ın minimum Date'i o an seçili olan checkIn tarihinden
        // 24 saat sonrası olarak ayarlanmalıdır.
        
        //addingTimeInterval:Var olan bir Date nesnesinin üzerine, belirtilen miktarda saniye ekler.
        let oneDay:Double = 24 * 60 * 60// 24 saatin saniye karşılığını belirtir.
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(oneDay)
        
        
        let dateFormatter = DateFormatter() //DateFormatter: tarihleri istediğimiz formatta göstermemizi saglar.
        dateFormatter.dateStyle = .medium //tarihleri medium formatında göster demiş olduk
        
        //checkInDateLabel'ın text ini, checkInDatePicker'dan seçilmiş olan date'in formatlanmış haliyle getir yaz demiş olduk.
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
    }
    
    func updateNumberOfGuests(){
        //stpeperdan gelen degeri labela yaz diyoruz stpeerdan douable geliypr biz Int'e çevirip string formatta yazdırıyoruz
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildernLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    func updateRoomType(){
        if let roomType = roomType{//roomType nil değilse.Ayarlandıysa.
            roomTypeLabel.text = roomType.name
        }else{
            roomTypeLabel.text = "Not Set"
        }
    }
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    //MARK: - Actions
    @IBAction func doneBarButtonTapped(_ button: UIBarButtonItem){
       print(registiration)
        
    }

    @IBAction func datePickerValueChanged(_ picker:UIDatePicker){
        updateDateViews()
    }
    
    @IBAction func stepperValuChanged(_ stepper:UIStepper){
        //Action yazmamızın nedeni Value degerleri sürekli değiştiği için
        updateNumberOfGuests()
    }
    @IBAction func wifiSwitchChanged(_ sender:UISwitch){
        
    }
    
    @IBAction func cancelBarButtonTapped(_ button: UIBarButtonItem){
        dismiss(animated: true,completion: nil)
    }
   

}
