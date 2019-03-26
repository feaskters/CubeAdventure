//
//  Checkpoints.m
//  TenLock
//
//  Created by iOS123 on 2019/2/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "Checkpoints.h"
@interface Checkpoints()



@end

@implementation Checkpoints

static Checkpoints *_instanceCheckpoint;

+(void)load{
    _instanceCheckpoint = [[Checkpoints alloc]init];
    //判断沙盒中是否有checkPoints.plist，没有则拷贝
    NSString *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [doc stringByAppendingString:@"/CheckPoints.plist"];
    
    // 复制到沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"CheckPoints" ofType:@"plist"];
        
        NSError *error ;
        if ([fileManager copyItemAtPath:sourcesPath toPath:path error:&error]) {
//            NSLog(@"移动成功");
        } else {
//            NSLog(@"移动失败");
        }
    }
    
    //读取数据到自身
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    _instanceCheckpoint.checkPointsArray = array;
}

+(instancetype)sharedCheckpoints{
    return _instanceCheckpoint;
}

//不允许alloc
+(instancetype)alloc{
    if (_instanceCheckpoint) {
        NSException *exc = [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one music instance." userInfo:nil];
        //抛出异常
        [exc raise];
    }
    return [super alloc];
}

//关卡成功，修改plist
-(void)successWithLevel:(int)level{
    if (level < _instanceCheckpoint.checkPointsArray.count) {
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray: _instanceCheckpoint.checkPointsArray copyItems:YES];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:array[level]];
        dic[@"enable"] = @YES;
        array[level] = dic;
        _instanceCheckpoint.checkPointsArray = array;
        //写入沙盒
        NSString *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [doc stringByAppendingString:@"/CheckPoints.plist"];
        [_instanceCheckpoint.checkPointsArray writeToFile:path atomically:YES];
    }
}


@end
