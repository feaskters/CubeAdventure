//
//  Checkpoints.h
//  TenLock
//
//  Created by iOS123 on 2019/2/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Checkpoints : NSObject

@property NSArray *checkPointsArray;
+(instancetype)sharedCheckpoints;
-(void)successWithLevel:(int)level;
@end

NS_ASSUME_NONNULL_END
