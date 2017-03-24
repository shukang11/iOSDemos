//
//  SSTabBarPage.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/24.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

//此界面未完成，使用系统的tabBar
class SSTabBarPage: UITabBarController,UITabBarControllerDelegate {
    
    //MARK:property属性
    var itemsTitle:[String] = []
    var images:[String] = []
    var selectedImages:[String] = []
    var subPages:[CommonViewController] = []
    
    //MARK:system系统
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.createMainUI()
        
    }
    //把系统中的自带的tabbar按钮移除
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        /*
        for child in self.tabBar.subviews {
            if child.isKind(of: UIControl.self) {
                child.removeFromSuperview()
            }
        }
         */
    }
    //MARK:-
    //MARK:delegate
    
    //MARK:customMethod自定义
    func createMainUI() {
        self.insert("首页", image: "首页", selectedImage: "首页-selected", subPage: HomePage())
        self.insert("继续教育", image: "继续教育", selectedImage: "继续教育-selected", subPage: TransportPage())
        self.insert("我的", image: "我的", selectedImage: "我的-selected", subPage: MyPage())
        
        for index in 0...(subPages.count - 1) {
            setUpChildVC(childVC: subPages[index], title: itemsTitle[index], imageName: images[index], selectedImage: selectedImages[index])
        }
    }
    
    //MARK:-
    //MARK:helper
    func insert(_ title:String, image:String, selectedImage:String, subPage:CommonViewController) -> Void {
        itemsTitle.append(title)
        images.append(image)
        selectedImages.append(selectedImage)
        subPages.append(subPage)
    }
    
    func setUpChildVC(childVC:CommonViewController, title:String, imageName:String, selectedImage:String) -> Void {
        let navigation:SSNavigationController = SSNavigationController.init(rootViewController: childVC)
        childVC.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        childVC.title = title
        childVC.tabBarItem.title = title
        
        //自定义的tabbar
        self.addChildViewController(navigation)
    }
}
