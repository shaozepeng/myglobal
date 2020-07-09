//
//  AppDelegate.h
//  testtouch
//
//  Created by 泽鹏邵 on 2020/6/24.
//  Copyright © 2020 泽鹏邵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;
@property (strong, nonatomic) UIWindow * window;
- (void)saveContext;


@end

