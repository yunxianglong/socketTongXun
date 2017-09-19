//
//  lyhaoSocketManager.h
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//  原生socket
/*
 socket：应用层与TCP/UDP进行交流的中间层（编程接口）
 1. 创建socket，connect
 2. 与服务器socket对接
 3. 数据传输
 4. close
 */

#import <Foundation/Foundation.h>

@interface lyhaoSocketManager : NSObject

+ (instancetype)shareInstance;
- (void)connect;
- (void)disConnect;
- (void)sendMsg:(NSString *)msg;

@end