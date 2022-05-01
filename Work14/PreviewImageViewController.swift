//
//  PreviewImage.swift
//  Work14
//
//  Created by 彭有駿 on 2022/4/29.
//

import UIKit
import PhotosUI

class PreviewImageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PHPickerViewControllerDelegate {
    
    
    
    @IBOutlet weak var previewImageView: UIImageView!
    //接受傳遞資料
    var editingImage:EditingImage
    var previewImage:UIImage
    init?(coder:NSCoder,passImage:UIImage,editingImage:EditingImage){
        self.previewImage = passImage
        self.editingImage = editingImage
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if editingImage == .backView{
            previewImageView.contentMode = .scaleAspectFill
        }else if editingImage == .headshot{
            previewImageView.contentMode = .scaleAspectFit
        }
        
  
        previewImageView.image = previewImage
        
    }

    @IBAction func dissmiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func editImage(_ sender: UIButton) {
        showAlertPhotoMessage()
    }
    
    
    
    @IBSegueAction func passImage(_ coder: NSCoder) -> EditImageViewViewController? {
        let controller = EditImageViewViewController(coder: coder,passImage: previewImage)
        return controller
    }
    
    
    
    
    func alert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    func showPhoto(){
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            alert(title: "提醒", message: "此裝置沒有相機")
            return
        }
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func showPhotoLibrary(){
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = self
        present(controller, animated: true, completion: nil)
        
    }
    
    func showAlertPhotoMessage(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photoAction = UIAlertAction(title: "開啟相機", style: .default) { _ in
            self.showPhoto()
            alert.dismiss(animated: true,completion: nil)
        }
        let photoLibraryAction = UIAlertAction(title: "選擇相簿照片", style:.default) { _ in
            print("開啟相簿")
            self.showPhotoLibrary()
            alert.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel){_ in
            alert.dismiss(animated: true,completion: nil)
            
        }
        alert.addAction(photoAction)
        alert.addAction(photoLibraryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProviders = results.map(\.itemProvider)
        if let itemProvider = itemProviders.first,itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.previewImage = image
                        picker.dismiss(animated: true) {
                            self.performSegue(withIdentifier:"showEditor", sender: nil)
                        }
                    }
                }
              
            }
        }else{
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
