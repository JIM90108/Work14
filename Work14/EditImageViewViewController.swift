//
//  EditImageViewViewController.swift
//  Work14
//
//  Created by 彭有駿 on 2022/4/29.
//

import UIKit

import CoreImage.CIFilterBuiltins

extension CGImagePropertyOrientation {
    //UIImage的照片面向
    init(_ uiOrientation: UIImage.Orientation) {
        //判斷照片面向
        switch uiOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
        @unknown default:
            self = .up
        }
    }
}

class EditImageViewViewController: UIViewController,UIScrollViewDelegate {
    
    
    @IBOutlet weak var drawView: UIView!
    
    
    @IBOutlet weak var rotateView: UIView!
    
    @IBOutlet weak var mirrorView: UIView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var previewScrollView:
    UIScrollView!
    
    @IBOutlet weak var editImageView: UIImageView!
    
    @IBOutlet var filterButtons: [UIButton]!
    
    
    var editingImage:UIImage
    
    let editor = ImageEditor()
    
    
    
    init?(coder:NSCoder,passImage:UIImage){
        self.editingImage = passImage
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        editImageView.image = editingImage
        editor.image = editingImage
        //button圖片濾鏡
        for (i,button) in filterButtons.enumerated(){
            button.configuration?.background.image = editor.changeImageFilter(tag: i)
        }
        previewScrollView.contentSize = editImageView.frame.size
        previewScrollView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    
  
    
    @IBAction func dissmiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func changeImageFilter(_ sender: UIButton) {
        editImageView.image = editor.changeImageFilter(tag: sender.tag)
    }
    
    
    
    @IBAction func turnRight(_ sender: UIButton) {
        editor.rotateImage(view: rotateView)
    }
    
    
    
    @IBAction func mirrorImage(_ sender: UIButton) {
        editor.mirrorImage(view: mirrorView)
    }
    
    
    
    @IBAction func scaleSegmentedControl(_ sender: UISegmentedControl) {
        editor.changeScale(index: sender.selectedSegmentIndex, view: previewScrollView)
    }
    
    @IBAction func complent(_ sender: UIButton) {
        editingImage = screenshot(view: drawView)
    }
    
    func screenshot(view:UIView)->UIImage{
        let renderer = UIGraphicsImageRenderer(bounds: CGRect(x:0 , y: 0, width:view.frame.width, height:view.frame.height))
               let image = renderer.image(actions: { (context) in
                   view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
               })
        return image
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
