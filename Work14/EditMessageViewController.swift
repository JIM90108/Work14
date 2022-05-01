//
//  EditMessageViewController.swift
//  Work14
//
//  Created by 彭有駿 on 2022/4/29.
//

import UIKit

class EditMessageViewController: UIViewController {
    
    
    
    @IBOutlet weak var editTextField: UITextField!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    let backgroundImage:UIImage
    let message:String
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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissSelf(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateCommentsTextCount(_ sender: UITextField) {
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
