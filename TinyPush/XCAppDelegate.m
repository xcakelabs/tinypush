//
//  XCAppDelegate.m
//  TinyPush
//
//  Created by Oisin Hurley on 08/07/2014.
//  Copyright (c) 2014 XcakeLabs. All rights reserved.
//

#import "XCAppDelegate.h"

@implementation XCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Register with iOS for notifications
    //
    UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];

    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Registration succeeded, meaning we have the correct APNS permissions
    // in our app
    NSLog(@"Registered for device token: %@", [self hexify:deviceToken]);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // Registration failed, meaning we do not have the correct APNS permissions
    // in our app, so we need to set them up in the developer portal. Of course,
    // this registration will also fail when we are running in the simulator!
    NSLog(@"Did not successfully register app for push notifications: %@", [[error userInfo] description]);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // The app has woken up with a push notification
    NSLog(@"Received a push notification: %@", [userInfo description]);
}

-(NSString *)hexify:(NSData*)data {
    if (data == nil) {
        return nil;
    }
    
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}
@end
