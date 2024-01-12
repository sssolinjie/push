#import "LbwpushPlugin.h"
#import "SPSDK/SPSDKLib.h"
#import "SPSDKGeo/SPLocationCenter.h"
#import "SPSDKMessage/SPSDKMessage.h""
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif



@implementation LbwpushPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"lbwpush"
                                     binaryMessenger:[registrar messenger]];
    //    LbwpushPlugin* instance = [[LbwpushPlugin alloc] init];
    //    [registrar addMethodCallDelegate:instance channel:channel];
    
    LbwpushPlugin *instance = [[LbwpushPlugin alloc] init];
    instance.channel = channel;
    [registrar addApplicationDelegate:instance];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }
    else if ([@"initsdk" isEqualToString:call.method]) {
        id para = call.arguments;
        [self initSDK :para];
    }else if ([@"getPushUid" isEqualToString:call.method]) {
        [self getPushUid:call result:result];
    }
    else if ([@"startPushService" isEqualToString:call.method]) {
        NSLog(@"startPushService ios is not function");
    }
    else if ([@"setAlias" isEqualToString:call.method]) {
        [self setAlias:call result:result];
    }
    else if ([@"getAlias" isEqualToString:call.method]) {
        [self getAlias:call result:result];
    }
    else if ([@"deleteAlias" isEqualToString:call.method]) {
        [self deleteAlias:call result:result];
    }
    else if ([@"addTags" isEqualToString:call.method]) {
        [self addTags:call result:result];
    }else if ([@"deleteTags" isEqualToString:call.method]) {
        [self deleteTags:call result:result];
    }else if ([@"updateTags" isEqualToString:call.method]) {
        [self updateTags:call result:result];
    }else if ([@"cleanTags" isEqualToString:call.method]) {
        [self cleanTags:call result:result];
    }else if ([@"getAllTags" isEqualToString:call.method]) {
        [self getAllTags:call result:result];
    }else if ([@"isTagBinding" isEqualToString:call.method]) {
        NSLog(@"isTagBinding ios is not function");
    }else if ([@"areNotificationsEnabled" isEqualToString:call.method]) {
        NSLog(@"areNotificationsEnabled ios is not function");
    }else if ([@"showNotificationGuide" isEqualToString:call.method]) {
        NSLog(@"showNotificationGuide ios is not function");
//        [_channel invokeMethod:@"onNotification1" arguments:@"你好"];
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

-(void) initSDK: (id)map{
    NSString* pushid = [SPSDKLib getPushId];
    [SPSDKLib startSDKWithAppkey:map[@"appkey"] secretKey:map[@"SecKey"] CUID:pushid];
    [self registerAPNs];
}

- (void)registerAPNs {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            // 请根据error自行处理
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType types = (UIRemoteNotificationType)
        (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication]
         registerForRemoteNotificationTypes:types];
    }
}


- (void)getPushUid:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* pushid = [SPSDKLib getPushId];
    result(pushid);
}
- (void)setAlias:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString  *alias = call.arguments;
    SPAsyncOperationCompletion completion = ^(NSError *error) {
        if (error) {
            result(@(FALSE));
        } else {
            result(@(YES));
        }
    };
    [SPSDKLib setAlias:alias completion:completion];
}
- (void)getAlias:(FlutterMethodCall*)call result:(FlutterResult)result {
    void(^completion)(NSError *, NSString *) = ^(NSError *error, NSString *aliasName) {
        if (error) {
            result(@"");
        } else {
            result(aliasName);
        }
    };
    [SPSDKLib getAlias:completion];
}
- (void)deleteAlias:(FlutterMethodCall*)call result:(FlutterResult)result {
    SPAsyncOperationCompletion completion = ^(NSError *error) {
        if (error) {
            result(@(FALSE));
        } else {
            result(@(YES));
        }
    };
    [SPSDKLib deleteAlias :completion];
}
- (void)addTags:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSSet *tags = call.arguments;
    SPAsyncOperationCompletion completion = ^(NSError *error) {
        if (error) {
            result(@(FALSE));
        } else {
            result(@(YES));
        }
    };
    [SPSDKLib addTags:tags withCompletion:completion];
}

- (void)deleteTags:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSSet *tags = call.arguments;
    SPAsyncOperationCompletion completion = ^(NSError *error) {
        if (error) {
            result(@(FALSE));
        } else {
            result(@(YES));
        }
    };
    [SPSDKLib deleteTags:tags withCompletion:completion];
}
- (void)updateTags:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSSet *tags = call.arguments;
    SPAsyncOperationCompletion completion = ^(NSError *error) {
        if (error) {
            result(@(FALSE));
        } else {
            result(@(YES));
        }
    };
    [SPSDKLib setTags:tags withComletion:completion];
}
- (void)cleanTags:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSSet *tags = call.arguments;
    SPAsyncOperationCompletion completion = ^(NSError *error) {
        if (error) {
            result(@(FALSE));
        } else {
            result(@(YES));
        }
    };
    [SPSDKLib clearTagsWithCompletion :completion];
}
- (void)getAllTags:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSSet *tags = call.arguments;
    void(^completionBlock)(NSError *, NSSet<NSString *> *) = ^(NSError *error, NSSet<NSString *> *tags) {
        if (error) {
            result(@"");
        } else {
            NSMutableString *str = [NSMutableString string];
            for (NSString *tag in tags) {
                if ([str length] > 0) {
                    [str appendString:@","];
                }
                [str appendString:tag];
            }
            result(str);
        }
    };
    [SPSDKLib getTagsWithCompletion :completionBlock];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
    //Xcode11打的包，iOS13获取Token有变化
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13) {
        if (![deviceToken isKindOfClass:[NSData class]]) {
            //记录获取token失败的描述
            return;
        }
        const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
        NSString *strToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                              ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                              ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                              ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        NSLog(@"deviceToken1:%@", strToken);
        [SPSDKLib registerDeviceToken:strToken withCompletion:^(NSError *error) {
            if (!error) {
                NSLog(@"注册设备ID成功");
                [_channel invokeMethod:@"initsucces" arguments:@""];
            } else {
                NSLog(@"error code : %@", error);
            }
        }];
    } else {
        NSString *token = [NSString
                       stringWithFormat:@"%@",deviceToken];
        token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"deviceToken2 is: %@", token);
        [SPSDKLib registerDeviceToken:token withCompletion:^(NSError *error) {
            if (!error) {
                NSLog(@"注册设备ID成功");
                [_channel invokeMethod:@"initsucces" arguments:@""];
            } else {
                NSLog(@"error code : %@", error);
            }
        }];
    }
}



// App前台运行时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
// 点击通知消息，App进入前台处理时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"%@", userInfo);
    [_channel invokeMethod:@"onNotification" arguments:userInfo];
}



@end
