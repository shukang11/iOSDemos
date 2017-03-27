//
//  HttpConstant.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/17.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation

public enum E_CMDCODE:UInt {
    case CC_Default                        =   0x0000//默认
    case CC_Login                          =   0x0001//学员登录
    case CC_UpdPwd                         =   0x0002//修改密码
    case CC_LogOut                         =   0x0003//登出
    case CC_StuInfo                        =   0x0004//个人资料
    case CC_GetAllBigClass                 =   0x0005//获得所有的大单元
    case CC_GetContinueStudyByBigId        =   0x0006//获得小单元
    case CC_GetContinueStudy               =   0x0007//登录以后继续学习
    case CC_GetStartPlayVideo              =   0x0008//开始学习当前视频
    case CC_GetStopPlayVideo               =   0x0009//结束学习当前的视频
    case CC_GetTiMuById                    =   0x000A//小单元结束以后获得题目
    case CC_GetStuJd                       =   0x000B//获得学员的学习进度
    case CC_AddYanZhengPhoto               =   0x000C//保存验证的图像
    case CC_GetMobileNum                   =   0x000D//向手机用户发送验证码
    case CC_CheckMobileNum                 =   0x000E//检查用户输入的验证码
    case CC_SetAppUser                     =   0x000F//添加app用户
    case CC_AppUpdate                      =   0x0020//手机端比较版本号
    case CC_AddSuggestion                  =   0x0021//添加建议或者意见
    case CC_FindOegtNotification           =   0x0022//获得有效的通知
    case CC_CheckStudentLoginState         =   0x0023//检查当前设备是不是活动设备
    
}
//需要验证登录信息的接口(需要token)
public func CC_NEED_LOGIN_QUEUE() -> [E_CMDCODE] {
    return [.CC_UpdPwd,
            .CC_LogOut,
            .CC_StuInfo,
            .CC_GetAllBigClass,
            .CC_GetContinueStudyByBigId,
            .CC_GetContinueStudy,
            .CC_GetStartPlayVideo,
            .CC_GetStopPlayVideo,
            .CC_GetTiMuById,
            .CC_GetStuJd,
            .CC_AddYanZhengPhoto,
            .CC_GetMobileNum,
            .CC_CheckMobileNum,
            .CC_AddSuggestion,
            .CC_CheckStudentLoginState]
}
//需要重写cookie的接口
public func CC_NEED_COOKIE_QUEUE() -> [E_CMDCODE] {
    return [E_CMDCODE.CC_FindOegtNotification]
}


//MARK: cookies
let HEADERS       = ["X-Requested-With": "XMLHttpRequest", "User-Agent": "transportClient"]

let kHost_baseURL = ""
let kHost_Truck_Base_UTL = "http://stu.ahjtpx.com/"//客货运输
let hHost_Danger_Base_URL = "http://stu.ahjtpx.com/"//危险品
let kHost_Taxi_Base_URL = "http://cztu.ahjtpx.com/"//出租车
let kHost_API_URL = "userApi/"//中间的url地址


let kHttpRequest_Login                          =   "login.do"//学员登录
let kHttpRequest_UpdPwd                         =   "updPwd.do"//修改密码
let kHttpRequest_logOut                         =   "logOut.do"//登出
let kHttpRequest_stuInfo                        =   "stuInfo.do"//个人资料
let kHttpRequest_getAllBigClass                 =   "getAllBigClass.do"//获得所有的大单元
let kHttpRequest_getContinueStudyByBigId        =   "getContinueStudyByBigId.do"//获得小单元
let kHttpRequest_getContinueStudy               =   "getContinueStudy.do"//登录以后继续学习
let kHttpRequest_getStartPlayVideo              =   "getStartPlayVideo.do"//开始学习当前视频
let kHttpRequest_getStopPlayVideo               =   "getStopPlayVideo.do"//结束学习当前的视频
let kHttpRequest_getTiMuById                    =   "getTiMuById.do"//小单元结束以后获得题目
let kHttpRequest_getStuJd                       =   "getStuJd.do"//获得学员的学习进度
let kHttpRequest_addYanZhengPhoto               =   "addYanZhengPhoto.do"//保存验证的图像
let kHttpRequest_getMobileNum                   =   "getMobileNum.do"//向手机用户发送验证码
let kHttpRequest_checkMobileNum                 =   "checkMobileNum.do"//检查用户输入的验证码
let kHttpRequest_setAppUser                     =   "setAppUser.do"//添加app用户
let kHttpRequest_appUpdate                      =   "appUpdate.do"//手机端比较版本号
let kHttpRequest_addSuggestion                  =   "addSuggestion.do"//添加建议或者意见
let kHttpRequest_findOegtNotification           =   "findOegtNotification.do"//获得有效的通知
let kHttpRequest_CheckStudentLoginState         =   "checkStudentLoginState.do"//检查当前设备是不是活动设备


let kHttp_Notice_ReqesutFailed = "网络连接失败，请稍后重试"
let kHttp_Notice_LoadingText = "加载中..."
let kHttp_Notice_UploadingText = "上传中..."
let kHttp_Notice_VerifyText = "验证中..."
let kHttp_Notice_GettingText = "获取中..."
let kHttp_Notice_SendingText = "发送中..."
