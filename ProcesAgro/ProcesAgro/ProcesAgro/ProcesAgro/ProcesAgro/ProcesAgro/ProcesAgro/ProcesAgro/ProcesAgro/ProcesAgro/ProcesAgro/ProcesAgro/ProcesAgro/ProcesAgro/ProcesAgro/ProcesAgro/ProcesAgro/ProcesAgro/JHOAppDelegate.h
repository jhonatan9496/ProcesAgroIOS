//
//  JHOAppDelegate.h
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 9/07/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,retain) NSString * dataBaseName;
@property (nonatomic, retain) NSString * dataBasePath;
@property (nonatomic, retain) NSMutableArray * tramiteVector;


@end
