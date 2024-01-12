//  SPSDKMessage.h
//  v1.1.8
//  Created by zangjianchao on 2020/5/9.
//  Copyright © 2020 Gong,Jialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
推送SDK:
自定义消息对外接口
*/

/**
异步消息回调函数:
@param message 透传消息
@param error 错误信息   
*/

/**
errorCode 描述:
 -1001 连接认证失败
 -1002 绑定服务器失败
 -1003 读取消息失败
 -1004 心跳消息失败
 -1005 重启服务限流
 -1006 服务器配置失败
 -1007 ecc认证加密错误
 -1008 服务端空消息错误
*/

typedef void (^SPAsyncMessageCompletion)(NSDictionary * _Nullable message, NSError * _Nullable error);

@interface SPSDKMessage : NSObject

//单例方法
+ (SPSDKMessage *)sharedInstance;

/**
接收透传消息:
@param completion 回调函数
*/
- (void)receiveSocketMessage:(SPAsyncMessageCompletion)completion;

@end

NS_ASSUME_NONNULL_END
