//
//  PNode.h
//  Breakout
//
//  Created by Main Account on 11/20/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWNode.h"
#include "btBulletDynamicsCommon.h"

#define kBallTag    1
#define kBrickTag   2
#define kPaddleTag  3
#define kBorderTag  4

@interface PNode : RWNode

- (instancetype)initWithName:(const char *)name
                        mass:(float)mass   //1
                      convex:(BOOL)convex  //2
                         tag:(int)tag      //3
                      shader:(GLKBaseEffect *)shader
                    vertices:(Vertex *)vertices
                 vertexCount:(unsigned int)vertexCount
                 textureName:(NSString *)textureName
               specularColor:(GLKVector4)specularColor
                diffuseColor:(GLKVector4)diffuseColor
                   shininess:(float)shininess;

//1
@property (nonatomic, readonly) btRigidBody* body;
//2
@property (nonatomic, assign)   int tag;

@end
