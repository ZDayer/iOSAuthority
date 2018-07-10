//
//  Define.h
//  iOSAuthority
//
//  Created by zhaoyang on 2018/7/10.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#ifndef Define_h
#define Define_h

/**
 *  ios 8判断
 */
#ifndef iOS8Later
#define iOS8Later  !([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending)
#endif

/**
 *  ios 9判断
 */
#ifndef iOS9Later
#define iOS9Later  !([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] == NSOrderedAscending)


#endif

/**
 *  ios 10判断
 */
#ifndef iOS10Later
#define iOS10Later  !([[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] == NSOrderedAscending)

#endif
/**
 *  ios 11判断
 */
#ifndef iOS11Later
#define iOS11Later  (([[[UIDevice currentDevice] systemVersion] floatValue] >=11.0)? (YES):(NO))
#endif

#endif /* Define_h */
