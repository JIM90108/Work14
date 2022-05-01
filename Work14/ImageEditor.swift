//
//  ImageEditor.swift
//  Work14
//
//  Created by 彭有駿 on 2022/5/1.
//

import UIKit
import CoreImage.CIFilterBuiltins
//編輯圖片類別
class ImageEditor{
    
    var image:UIImage?
    let degree = CGFloat.pi/180
    //原圖尺寸
    let defaultLength:CGFloat = 360
    var turnRightTimes:CGFloat = 0{
        didSet{
            if turnRightTimes == 4{
                turnRightTimes = 0
            }
        }
    }
    var mirrorNumber:CGFloat = 1
    
    //濾鏡
    func changeImageFilter(tag:Int)->UIImage?{
        let defaultImage = image
        switch tag{
        case 0:
            return defaultImage
        case 1:
            return changeFilter(image: image, tag: tag)
        case 2:
            return changeFilter(image: image, tag: tag)
        case 3:
            return changeFilter(image: image, tag: tag)
        case 4:
            return changeFilter(image: image, tag: tag)
        case 5:
            return changeFilter(image: image, tag: tag)
        default:
            return nil
        }
    }
    
    func changeFilter(image:UIImage?,tag:Int)->UIImage?{
        guard let image = image else {return nil}
        let ciImage = CIImage(image:image)
        var name = ""
        switch tag {
        case 1:
            name = "CIColorMonochrome"
        case 2:
            name = "CIPhotoEffectFade"
        case 3:
            name = "CIPhotoEffectInstant"
        case 4:
            name = "CIPhotoEffectMono"
        case 5:
            name = "CIPhotoEffectTransfer"
        default:
            break
        }
        
        //帶入要使用的濾鏡名稱(濾鏡功能)
        let filter = CIFilter(name: name)
        //放入圖片(forKey的意思是用input的圖片)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        //output是濾鏡過後的圖片
        if let outputImage = filter?.outputImage{
            //將CIImage的面向轉回跟原圖相同
            let rotateCIImage = outputImage.oriented(CGImagePropertyOrientation(image.imageOrientation))
            let newImage = UIImage(ciImage: rotateCIImage)
            return newImage
        }
        return nil
    }
    
    //旋轉圖片
    func rotateImage(view:UIView){
        turnRightTimes += 1
        view.transform = CGAffineTransform.identity.rotated(by: degree*90*turnRightTimes)
       
    }
    //鏡像圖片
    func mirrorImage(view:UIView){
        mirrorNumber *= -1
        view.transform = CGAffineTransform.identity.scaledBy(x: mirrorNumber, y: 1)
    }
    
    //變更圖像比例
    func changeScale(index:Int,view:UIView){
        var width:CGFloat
        var height:CGFloat
        switch index{
        case 0:
            width = defaultLength
            height = defaultLength
        case 1:
            width = defaultLength/896*414
            height = defaultLength
        case 2:
            width = defaultLength
            height = defaultLength/16*9
        case 3:
            width = defaultLength
            height = defaultLength/4*3
        default:
            return
        }
        view.frame.size = CGSize(width: width, height: height)
        view.center = CGPoint(x: defaultLength/2, y: defaultLength/2)
    }
}
