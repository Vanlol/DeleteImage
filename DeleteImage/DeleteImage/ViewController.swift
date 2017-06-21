//
//  ViewController.swift
//  DeleteImage
//
//  Created by admin on 2017/6/19.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate lazy var imageVi:UIImageView = {
        let vi = UIImageView(image: UIImage(named: "3"))
        vi.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        return vi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageVi)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /** 图片擦除 **/
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        let wh:CGFloat = 10
        let touch = (touches as NSSet).anyObject() as! UITouch
        var prePo = touch.previousLocation(in: view)
        let curPo = touch.location(in: view)
        let absMoveX = abs(curPo.x - prePo.x)
        let moveX = curPo.x - prePo.x
        let absMoveY = abs(curPo.y - prePo.y)
        let moveY = curPo.y - prePo.y
        let context = UIGraphicsGetCurrentContext()
        imageVi.layer.render(in: context!)
        if absMoveX > wh && absMoveY > wh {
            let countX = Int(absMoveX / wh) + 1
            let countY = Int(absMoveY / wh) + 1
            if countY >= countX {
                let x = absMoveX / CGFloat(countY)
                for _ in 0..<countY {
                    if moveY >= 0 {
                        prePo.y += wh
                    }else{
                        prePo.y -= wh
                    }
                    if moveX >= 0 && curPo.x > prePo.x {
                        prePo.x += x
                    }else if moveX <= 0 && curPo.x < prePo.x {
                        prePo.x -= x
                    }
                    context?.clear(CGRect(x: prePo.x + wh * 0.5, y: prePo.y + wh * 0.5, width: wh, height: wh))
                }
            }else{
                let y = absMoveY / CGFloat(countX)
                for _ in 0..<countX {
                    if moveX >= 0 {
                        prePo.x += wh
                    }else{
                        prePo.x -= wh
                    }
                    if moveY >= 0 && curPo.y > prePo.y {
                        prePo.y += y
                    }else if moveY <= 0 && curPo.y < prePo.y{
                        prePo.y -= y
                    }
                    context?.clear(CGRect(x: prePo.x + wh * 0.5, y: prePo.y + wh * 0.5, width: wh, height: wh))
                }
            }
        }else if absMoveX > wh  {
            let count = Int(absMoveX / wh) + 1
            let y = absMoveY / CGFloat(count)
            for _ in 0..<count {
                if moveX >= 0 {
                    prePo.x += wh
                }else{
                    prePo.x -= wh
                }
                if moveY >= 0 && curPo.y > prePo.y {
                    prePo.y += y
                }else if moveY <= 0 && curPo.y < prePo.y{
                    prePo.y -= y
                }
                context?.clear(CGRect(x: prePo.x + wh * 0.5, y: prePo.y + wh * 0.5, width: wh, height: wh))
            }
        }else if absMoveY > wh  {
            let count = Int(absMoveY / wh) + 1
            let x = absMoveX / CGFloat(count)
            for _ in 0..<count {
                if moveY >= 0 {
                    prePo.y += wh
                }else{
                    prePo.y -= wh
                }
                if moveX >= 0 && curPo.x > prePo.x {
                    prePo.x += x
                }else if moveX <= 0 && curPo.x < prePo.x {
                    prePo.x -= x
                }
                context?.clear(CGRect(x: prePo.x + wh * 0.5, y: prePo.y + wh * 0.5, width: wh, height: wh))
            }
        }else{
            context?.clear(CGRect(x: prePo.x + wh * 0.5, y: prePo.y + wh * 0.5, width: wh, height: wh))
        }
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageVi.image = newImg
    }
    
    
    
    
    
    
    
    
    
    
    
}

