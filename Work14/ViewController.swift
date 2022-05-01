//
//  ViewController.swift
//  Work14
//
//  Created by 彭有駿 on 2022/4/29.
//

import UIKit



enum EditingImage{
    case backView
    case headshot
}


class ViewController: UIViewController {
    
    
    @IBOutlet weak var backViewImage: UIImageView!
    
    @IBOutlet weak var headshotImage: UIImageView!
    
    @IBOutlet weak var headshot2Image: UIImageView!
    
    @IBOutlet weak var messageNameButton: UIButton!
    
    @IBOutlet weak var messageSmallNameButton: UIButton!
    
    @IBOutlet weak var messageName2Button: UIButton!
    
    
    @IBOutlet weak var messageSmallName2Button: UIButton!
    
    var editButton:UIButton?
    
    var previewImage:UIImage?
    var editinagImage:EditingImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func headshotImage(_ sender: UITapGestureRecognizer) {
        previewImage = headshotImage.image
        editinagImage  = .headshot
        performSegue(withIdentifier: "previewImage", sender: nil)
    }
    
    @IBAction func headshotImage2(_ sender: UITapGestureRecognizer) {
        previewImage = headshot2Image.image
        editinagImage = .backView
        performSegue(withIdentifier: "previewImage", sender: nil)
    }
    
    
    
    @IBSegueAction func passImage(_ coder: NSCoder) -> PreviewImageViewController? {
        guard let editinagImage = editinagImage,let previewImage = previewImage else{return PreviewImageViewController(coder: coder)
        }
        return PreviewImageViewController(coder: coder, passImage: previewImage, editingImage: editinagImage)
    }
    
    @IBSegueAction func passMessage(_ coder: NSCoder) -> UIViewController? {
        guard let image = backViewImage.image ,let message = messageNameButton.configuration?.title else{
            return PreviewMessageViewController(coder: coder)}
        let controller = PreviewMessageViewController(coder: coder,backgroundImage: image,message: message)
        editButton = messageNameButton
        return controller
        }
    
    @IBSegueAction func passSmallMessage(_ coder: NSCoder) -> UIViewController? {
        guard let image = backViewImage.image ,let message2 = messageSmallNameButton.configuration?.title else{
            return PreviewMessageViewController(coder: coder)}
        let controller = PreviewMessageViewController(coder: coder,backgroundImage: image,message: message2)
        editButton = messageSmallNameButton
        return controller
        
    }
    
    
    @IBSegueAction func passMessage2(_ coder: NSCoder) -> UIViewController? {
        guard let image = backViewImage.image ,let message2 = messageName2Button.configuration?.title else{
            return PreviewMessageViewController(coder: coder)}
        let controller = PreviewMessageViewController(coder: coder,backgroundImage: image,message: message2)
        editButton = messageName2Button
        return controller
    }
    
    
    @IBSegueAction func passSmallMessage2(_ coder: NSCoder) -> UIViewController? {
        guard let image = backViewImage.image ,let message2 = messageSmallName2Button.configuration?.title else{
            return PreviewMessageViewController(coder: coder)}
        let controller = PreviewMessageViewController(coder: coder,backgroundImage: image,message: message2)
        editButton = messageSmallName2Button
        return controller
    }
    
    
    
    
    
    @IBAction func unwindToMainViewController(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? EditMessageViewController{
            editButton?.configuration?.title = sourceViewController.editTextField.text
        }
        if let sourceViewController = unwindSegue.source as? EditImageViewViewController{
            switch editinagImage{
            case .backView:
                headshot2Image.image = sourceViewController.editingImage
            case .headshot:
                headshotImage.image = sourceViewController.editingImage
            default:
                return
            }
        }

        }
    
    
    
    
    
    
    }
    
    
    
    
