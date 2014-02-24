//
//  RWNode.h
//  HelloOpenGL
//
//  Created by Main Account on 8/31/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"
#import <GLKit/GLKit.h>

@interface RWNode : NSObject

@property (nonatomic, strong) GLKBaseEffect *shader;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic) float rotationX;
@property (nonatomic) float rotationY;
@property (nonatomic) float rotationZ;
@property (nonatomic) float scale;
@property (nonatomic) GLuint texture;
@property (nonatomic, assign) GLKVector4 specularColor;
@property (nonatomic, assign) GLKVector4 diffuseColor;
@property (nonatomic, assign) float shininess;

@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;

- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(Vertex *)vertices vertexCount:(unsigned int)vertexCount;
- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(Vertex *)vertices vertexCount:(unsigned int)vertexCount textureName:(NSString *)textureName specularColor:(GLKVector4)specularColor diffuseColor:(GLKVector4)diffuseColor shininess:(float)shininess;

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (GLKMatrix4)modelMatrix;
- (void)updateWithDelta:(GLfloat)aDelta;
- (void)loadTexture:(NSString *)filename;
- (CGRect)boundingBoxWithModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
