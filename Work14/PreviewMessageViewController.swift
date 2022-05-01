//
//  PreviewMessageViewController.swift
//  Work14
//
//  Created by 彭有駿 on 2022/4/29.
//

import UIKit

class PreviewMessageViewController: UIViewController {
    
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //接收資料
    var message:String
    var backgroundImage:UIImage
    
    
    init?(coder:NSCoder,backgroundImage:UIImage,message:String){
        self.backgroundImage = backgroundImage
        self.message = message
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsLabel.text = message
        backgroundImageView.image = backgroundImage

    }
    
    @IBAction func dismissSelf(_ sender: UIButton) {
        self.dismiss(animated: true,completion: nil)
    }
    
    
    @IBSegueAction func passCommentsToEdit(_ coder: NSCoder) -> EditMessageViewController? {
        let controller = EditMessageViewController(coder: coder,backgroundImage: backgroundImage,message: message)
        return controller
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
