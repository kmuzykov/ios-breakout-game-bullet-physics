//
//  RWGameScene.m
//  Breakout
//
//  Created by Main Account on 8/29/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWGameScene.h"
#import "RWBall.h"
#import "RWBorder.h"
#import "RWBrick.h"
#import "RWPaddle.h"
#import "RWDirector.h"
#import "RWGameOverScene.h"
#include "btBulletDynamicsCommon.h"
#import "PNode.h"

#define BRICKS_PER_COL 8
#define BRICKS_PER_ROW 9

@implementation RWGameScene {
    CGSize _gameArea;
    float _sceneOffset;
    RWBall *_ball;
    RWBorder *_border;
    NSMutableArray *_bricks;
    RWPaddle *_paddle;
  
    CGPoint _previousTouchLocation;
    float _ballVelocityX;
    float _ballVelocityY;
    
    btBroadphaseInterface*                  _broadphase;
    btDefaultCollisionConfiguration*        _collisionConfiguration;
    btCollisionDispatcher*                  _dispatcher;
    btSequentialImpulseConstraintSolver*    _solver;
    btDiscreteDynamicsWorld*                _world;
    btScalar   _desiredVelocity;
}

- (instancetype)initWithShader:(GLKBaseEffect *)shader {
  if ((self = [super initWithName:"RWGameScene" shader:shader vertices:nil vertexCount:0])) {
    
    [self initPhysics];
    
    // Create initial scene position (i.e. camera)
    _gameArea = CGSizeMake(27, 48);
    _sceneOffset = _gameArea.height/2 / tanf(GLKMathRadiansToDegrees(85.0/2));
    self.position = GLKVector3Make(-_gameArea.width/2, -_gameArea.height/2 + 10, -_sceneOffset);
    self.rotationX = GLKMathDegreesToRadians(-45);
    
    // Create paddle near bottom of screen
    _paddle = [[RWPaddle alloc] initWithShader:shader];
    _paddle.position = GLKVector3Make(_gameArea.width/2, _gameArea.height * 0.05, 0);
    _paddle.diffuseColor = GLKVector4Make(1, 0, 0, 1);
    [self.children addObject:_paddle];
    _world->addRigidBody(_paddle.body);
    
    // Create ball right above paddle
    _ball = [[RWBall alloc] initWithShader:shader];
    _ball.position = GLKVector3Make(_gameArea.width/2, _gameArea.height * 0.1, 0);
    _ball.diffuseColor = GLKVector4Make(0.5, 0.9, 0, 1);
    [self.children addObject:_ball];
    _world->addRigidBody(_ball.body); //Adding ball to world
    _ball.body->setLinearVelocity(btVector3(15,15,0));
    _desiredVelocity = _ball.body->getLinearVelocity().length();
    
    // Add border in center of screen
    _border = [[RWBorder alloc] initWithShader:shader];
    _border.position = GLKVector3Make(_gameArea.width/2, _gameArea.height/2, 0);
    [self.children addObject:_border];
    _world->addRigidBody(_border.body);
    
    // Generate colors for bricks
    GLKVector4 colors[BRICKS_PER_ROW];
    for (int i = 0; i < BRICKS_PER_ROW; i++) {
      colors[i] = [self color:(float)(BRICKS_PER_ROW-i) / (float)BRICKS_PER_ROW];
    }
    
    // Generate array of bricks
    _bricks = [NSMutableArray arrayWithCapacity:72];
    for (int j = 0; j < BRICKS_PER_COL; ++j)
    {
      for (int i = 0; i < BRICKS_PER_ROW; ++i)
      {
        RWBrick *brick = [[RWBrick alloc] initWithShader:shader];
        float margin = _gameArea.width * 0.1;
        float startY = _gameArea.height * 0.5;
        brick.position = GLKVector3Make(margin + (margin * i), startY + (margin * j), 0);
        brick.diffuseColor = colors[i];
        [self.children addObject:brick];
        [_bricks addObject:brick];
        _world->addRigidBody(brick.body);
      }
    }
    
  }
  return self;
}

-(void)initPhysics
{
    //1
    _broadphase = new btDbvtBroadphase();
 
    //2
    _collisionConfiguration = new btDefaultCollisionConfiguration();
    _dispatcher = new btCollisionDispatcher(_collisionConfiguration);
 
    //3
    _solver = new btSequentialImpulseConstraintSolver();
 
    //4
    _world = new btDiscreteDynamicsWorld(_dispatcher, _broadphase, _solver, _collisionConfiguration);
 
    //5
    _world->setGravity(btVector3(0, 0, 0));
}

- (void)dealloc
{    
    delete _world;
    delete _solver;
    delete _collisionConfiguration;
    delete _dispatcher;
    delete _broadphase;
}

// http://stackoverflow.com/questions/470690/how-to-automatically-generate-n-distinct-colors
- (GLKVector4)color:(float)x {
	float r = 0.0f;
	float g = 0.0f;
	float b = 1.0f;
	if (x >= 0.0f && x < 0.2f) {
		x = x / 0.2f;
		r = 0.0f;
		g = x;
		b = 1.0f;
	} else if (x >= 0.2f && x < 0.4f) {
		x = (x - 0.2f) / 0.2f;
		r = 0.0f;
		g = 1.0f;
		b = 1.0f - x;
	} else if (x >= 0.4f && x < 0.6f) {
		x = (x - 0.4f) / 0.2f;
		r = x;
		g = 1.0f;
		b = 0.0f;
	} else if (x >= 0.6f && x < 0.8f) {
		x = (x - 0.6f) / 0.2f;
		r = 1.0f;
		g = 1.0f - x;
		b = 0.0f;
	} else if (x >= 0.8f && x <= 1.0f) {
		x = (x - 0.8f) / 0.2f;
		r = 1.0f;
		g = 0.0f;
		b = x;
	}
	return GLKVector4Make(r, g, b, 1.0);
}

- (CGPoint)touchLocationToGameArea:(CGPoint)touchLocation {
    
    // Perform calculation to convert touch location to game area
    float ratio = [RWDirector sharedInstance].view.frame.size.height / _gameArea.height;
    float actualX = touchLocation.x / ratio;
    float actualY = ([RWDirector sharedInstance].view.frame.size.height - touchLocation.y) / ratio;
    CGPoint actual = CGPointMake(actualX, actualY);
    
    NSLog(@"Actual touch: %@", NSStringFromCGPoint(actual));
    return actual;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Store previous touch location
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:[RWDirector sharedInstance].view];
    _previousTouchLocation = [self touchLocationToGameArea:touchLocation];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    // Get current touch location
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:[RWDirector sharedInstance].view];
    touchLocation = [self touchLocationToGameArea:touchLocation];

    // Calculate diff between previous touch location and current touch location
    CGPoint diff = CGPointMake(touchLocation.x - _previousTouchLocation.x, touchLocation.y - _previousTouchLocation.y);
    _previousTouchLocation = touchLocation;
    
    // Move paddle's position based on the diff
    float newX = _paddle.position.x + diff.x;
    newX = MIN(MAX(newX, _paddle.width/2), _gameArea.width - _paddle.width/2);
    _paddle.position = GLKVector3Make(newX, _paddle.position.y, _paddle.position.z);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)updateWithDelta:(GLfloat)aDelta {
    //1
    [super updateWithDelta:aDelta];
 
    //2
    _world->stepSimulation(aDelta);
 
    //3
    //NSLog(@"Ball height: %f", _ball.body->getWorldTransform().getOrigin().getY());
    
    if (_ball.position.y < 0)
    {
        [RWDirector sharedInstance].scene = [[RWGameOverScene alloc] initWithShader:self.shader win:NO];
        return;
    }
    
    //1
    int numManifolds = _world->getDispatcher()->getNumManifolds();
    for (int i=0;i<numManifolds;i++)
    {
        //2
        btPersistentManifold* contactManifold =  _world->getDispatcher()->getManifoldByIndexInternal(i);
     
        //3
        int numContacts = contactManifold->getNumContacts();
        if (numContacts > 0)
        {
                //4
                [[RWDirector sharedInstance] playPopEffect];
     
                //5
                const btCollisionObject* obA = contactManifold->getBody0();
                const btCollisionObject* obB = contactManifold->getBody1();
     
                //6
                PNode* pnA = (__bridge PNode*)obA->getUserPointer();
                PNode* pnB = (__bridge PNode*)obB->getUserPointer();
     
                //7
                if (pnA.tag == kBrickTag) {
                    [self destroyBrickAndCheckVictory:pnA];
                }
     
                //8
                if (pnB.tag == kBrickTag){
                    [self destroyBrickAndCheckVictory:pnB];
                }
        }
    }
 
    btVector3 currentVelocityDirection =_ball.body->getLinearVelocity();
    btScalar currentVelocty = currentVelocityDirection.length();
    if (currentVelocty < _desiredVelocity)
    {
        currentVelocityDirection *= _desiredVelocity/currentVelocty;
        _ball.body->setLinearVelocity(currentVelocityDirection);
    }
    
}

- (void)destroyBrickAndCheckVictory:(PNode*)brick
{
    //1
    [self.children removeObject:brick];
    [_bricks removeObject:brick];
 
    //2
    _world->removeRigidBody(brick.body);
 
    //3
    if (_bricks.count == 0) {
        [RWDirector sharedInstance].scene = [[RWGameOverScene alloc] initWithShader:self.shader win:YES];
    }
}

//- (void)updateWithDelta:(GLfloat)aDelta {
//    
//    [super updateWithDelta:aDelta];
//    
//    // Update position of ball and bounce off edges
//    float newX = _ball.position.x + _ballVelocityX * aDelta;
//    float newY = _ball.position.y + _ballVelocityY * aDelta;
//    BOOL bounced = FALSE;
//
//    if (newX < 0) {
//        newX = 0;
//        _ballVelocityX = -_ballVelocityX;
//        bounced = TRUE;
//    }
//    if (newY < 0) {
//        newY = 0;
//        _ballVelocityY = -_ballVelocityY;
//        bounced = TRUE;
//        [RWDirector sharedInstance].scene = [[RWGameOverScene alloc] initWithShader:self.shader win:NO];
//    }
//    if (newX > 27.0) {
//        newX = 27.0;
//        _ballVelocityX = -_ballVelocityX;
//        bounced = TRUE;
//    }
//    if (newY > 48.0) {
//        newY = 48.0;
//        _ballVelocityY = -_ballVelocityY;
//        bounced = TRUE;
//    }
//  
//    if (bounced) {
//        [[RWDirector sharedInstance] playPopEffect];
//    }
//    
//    _ball.position = GLKVector3Make(newX, newY, _ball.position.z);
//    
//    // Get bounding boxes of ball and paddle (in 2D game plane)
//    CGRect ballRect = [_ball boundingBoxWithModelViewMatrix:GLKMatrix4Identity];
//    CGRect paddleRect = [_paddle boundingBoxWithModelViewMatrix:GLKMatrix4Identity];
//
//    // Check to see if ball and paddle intersect - if so, make ball go up
//    if (CGRectIntersectsRect(ballRect, paddleRect)) {
//        _ballVelocityY = ABS(_ballVelocityY);
//        [[RWDirector sharedInstance] playPopEffect];
//    }
//  
//    // Check to see if ball hits any bricks - if so mark it to be destroyed
//    RWBrick * brickToDestroy = nil;
//    for (RWBrick * brick in _bricks) {
//        CGRect brickRect = [brick boundingBoxWithModelViewMatrix:GLKMatrix4Identity];
//        
//        if (CGRectIntersectsRect(brickRect, ballRect)) {
//            NSLog(@"Hit!");
//            brickToDestroy = brick;
//            break;
//        }
//    }
//  
//    // Destory brick
//    if (brickToDestroy) {
//        [self.children removeObject:brickToDestroy];
//        [_bricks removeObject:brickToDestroy];
//        _ballVelocityY = -_ballVelocityY;
//        [[RWDirector sharedInstance] playPopEffect];
//    }
//  
//    // Check for win
//    if (_bricks.count == 0) {
//        [RWDirector sharedInstance].scene = [[RWGameOverScene alloc] initWithShader:self.shader win:YES];
//    }
//}

@end
