//
//  SPushProject
//  v1.1.8
//
//  Copyright © 2018年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIApplication.h>

extern NSString * const kSPSDKLibIdfvIdentifier; // idfv

/**
 本地通知配置中的通知内容，作为属性使用
 */
@interface SPNotificationContent : NSObject

@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *subtitle; // 副标题
@property (nonatomic, copy) NSString *body; // 内容
@property (nonatomic, copy) NSNumber *badge; // 角标数字
@property (nonatomic, copy) NSDictionary *userInfo; // 附加信息
@property (nonatomic, copy) NSString *soundName; // 使用声音文件名称

@end


/**
 本地通知配置对象
 */
@interface SPNotificationConfig : NSObject

@property (nonatomic, copy) NSString *notificationIdentifier; // 通知的唯一标识
@property (nonatomic, strong) SPNotificationContent *content; // 通知内容

@property (nonatomic, copy) NSDate *fireDate NS_DEPRECATED_IOS(2_0, 10_0); // 触发时间，iOS10以下使用

@property (nonatomic, assign) BOOL repeat NS_AVAILABLE_IOS(10_0); // 是否重复，配合timeInterval使用，iOS10以上支持
@property (nonatomic, copy) void (^completionHandler)(NSError *error)  NS_AVAILABLE_IOS(10_0); // 本地通知注册后回调，根据error判断是否成功，iOS10以上支持
@property (nonatomic, copy) NSDateComponents *dateComponents NS_AVAILABLE_IOS(10_0); // 触发时间，iOS10以上支持
@property (nonatomic, assign) NSTimeInterval timeInterval NS_AVAILABLE_IOS(10_0); // 触发前时间间隔，dateComponents存在时失效，iOS10以上支持

@end


typedef void (^SPAsyncOperationCompletion)(NSError *error);//错误回调

/**
 推送SDK对外接口
 */
@interface SPSDKLib : NSObject


/**
 启动SDK，只需要调用一次即可

 @param appkey 渠道Appkey，需要提前申请
 @param secretKey 配合Appkey使用，需要提前申请
 @param cuid 用于统计设备的cuid
 */
+ (void)startSDKWithAppkey:(NSString *)appkey secretKey:(NSString *)secretKey CUID:(NSString *)cuid;


/**
 启动SDK，只需要调用一次即可

 @param appkey 渠道Appkey，需要提前申请
 @param secretKey 配合Appkey使用，需要提前申请
 @param cuid 用于统计设备的cuid
 @param deviceInfo 设备的信息 IDFV例子:@{kSPSDKLibIdfvIdentifier:@""}
 */
+ (void)startSDKWithAppkey:(NSString *)appkey secretKey:(NSString *)secretKey CUID:(NSString *)cuid deviceInfo:(NSDictionary *)deviceInfo;

/**
 注册DeviceToken

 @param deviceToken 注册监听回调的device token
 @param completion 执行完成回调
 */
+ (void)registerDeviceToken:(NSString *)deviceToken withCompletion:(SPAsyncOperationCompletion)completion;

/**
 获取PushId
 
 @return PushId，40位字符串
 */
+ (NSString *)getPushId;

/**
 添加本地通知到通知队列

 @param notificationConfig 本地通知配置，如果没有延迟时间则立即触发
 */
+ (void)addLocalNotification:(SPNotificationConfig *)notificationConfig;

/**
 取消未触发的本地通知

 @param notificationIdentifiers 数组，包含notificationIdentifier，根据notificationIdentifier进行取消
 */
+ (void)cancelLocalNotificationWithIdentifier:(NSArray *)notificationIdentifiers;

/**
 清除所有未触发的本地通知
 */
+ (void)clearAllLocalNotifications;

/**
 通知服务端当前badge值

 @param badge 当前客户端badge数量
 @param completion 执行完成回调
 */
+ (void)setBadge:(NSInteger)badge withCompletion:(SPAsyncOperationCompletion)completion;

/**
 批量增加tag

 @param tags tag集合
 @param completion 回调函数
 */
+ (void)addTags:(NSSet<NSString *> *)tags withCompletion:(SPAsyncOperationCompletion)completion;

/**
 批量删除tag

 @param tags tag集合
 @param completion 回调函数
 */
+ (void)deleteTags:(NSSet<NSString *> *)tags withCompletion:(SPAsyncOperationCompletion)completion;

/**
 批量更新tag，会把旧tag删除

 @param tags 需要保留的tags
 @param completion 回调函数
 */
+ (void)setTags:(NSSet<NSString *> *)tags withComletion:(SPAsyncOperationCompletion)completion;

/**
 清除所有tag

 @param completion 回调函数
 */
+ (void)clearTagsWithCompletion:(SPAsyncOperationCompletion)completion;

/**
 获取所有tag

 @param completionBlock 回调函数，NSError 表示错误代码，NSSet表示查询到当前的Tags
 */
+ (void)getTagsWithCompletion:(void(^)(NSError *, NSSet<NSString *> *))completionBlock;

/**
 上报收到远程通知事件

 @param userInfo 远程通知参数
 @param applicationState 收到通知时App所处状态
 */
+ (void)didRevRemoteNotification:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState didClick:(BOOL)click;

/**
 设置Alias

 @param alias 需要设置的alias
 @param completion 响应回调
 */
+ (void)setAlias:(NSString *)alias
      completion:(SPAsyncOperationCompletion)completion;

/**
 删除alias
 
 @param completion 响应回调
 */
+ (void)deleteAlias:(SPAsyncOperationCompletion)completion;


/**
 查询当前alias

 @param completion 响应回调 error 表示错误代码，, NSString 表示绑定后的别名
 */
+ (void)getAlias:(void(^)(NSError *error, NSString *aliasName))completion;


@end
