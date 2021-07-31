//
//  CMManager.h
//  WKProject
//
//  Created by Hibiscus on 2017/4/4.
//  Copyright © 2017年 WK. All rights reserved.
//

/**
 *  常用方法管理器
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SingletonTemplate.h"   // 单例模板

@interface CMManager : NSObject

singleton_for_header(CMManager)

#pragma mark - 判断字符串是否为空
/**
 *  判断字符串是否为空
 *
 *  @param string 要判断的字符串
 *
 *  @return 返回YES为空，NO为不空
 */
- (BOOL)isBlankString:(NSString *)string;

#pragma mark - 判断是否为真实手机号码
/**
 *  判断是否为真实手机号码
 *
 *  @param _text 手机号
 *
 *  @return 返回YES为真实手机号码，NO为否
 */
- (BOOL)checkInputMobile:(NSString *)_text;

#pragma mark - 判断email格式是否正确
/**
 *  判断email格式是否正确
 *
 *  @param emailString 邮箱
 *
 *  @return 返回YES为Email格式正确，NO为否
 */
- (BOOL)isAvailableEmail:(NSString *)emailString;

#pragma mark - 姓名验证
/**
 *  姓名验证
 *
 *  @param name 姓名
 *
 *  @return 返回YES为姓名规格正确，NO为否
 */
- (BOOL)isValidateName:(NSString *)name;



#pragma mark - 身份证验证
/**
 *  身份证验证
 *
 *  @param value 姓名
 *
 *  @return 返回YES为身份证规格正确，NO为否
 */

- (BOOL)isValidateIDCard:(NSString *)value;

#pragma mark - 获取当前使用语言
/**
 *  获取当前使用语言
 *
 *  @return 当前使用语言
 */
- (NSString *)currentLanguage;

#pragma mark - 打印出项目工程里自定义字体名
/**
 *  打印出项目工程里自定义字体名
 */
- (void)printCustomFontName;

#pragma mark - 获取手机ip地址
/**
 *  传YES，返回ipv4地址，传NO，返回ipv6地址
 */
- (NSString *)getIPAddress:(BOOL)preferIPv4;

#pragma mark 弹出提示框
/**
 *  传要弹出的消息
 */
- (void)showTipsWithMsg:(NSString *)message;

/**
 *  传要弹出的消息
 */
- (void)showSubmitSuccess;

- (void)showReportTips;
@end
