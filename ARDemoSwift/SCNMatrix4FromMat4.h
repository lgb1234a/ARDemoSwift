//
//  SCNMatrix4FromMat4.h
//  ARDemoSwift
//
//  Created by chenyn on 2017/6/27.
//  Copyright © 2017年 chenyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKitTypes.h>

@interface SCNMatrix4FromMat4Class : NSObject

+ (SCNMatrix4)SCNMatrix4FromMat4Mth:(matrix_float4x4)originMatrix;

@end
