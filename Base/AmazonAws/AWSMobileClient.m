//
//  AWSMobileHubClient.m
//
//
// Copyright 2017 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-objc v0.17
//
//
#import "AWSMobileClient.h"
#import <AWSMobileHubHelper/AWSMobileHubHelper.h>

@interface AWSMobileClient ()

@property (nonatomic) BOOL initialized;

@end

@implementation AWSMobileClient

- (instancetype)init {
    AWSLogDebug(@"init");
    self = [super init];
    _initialized = NO;
    [AWSLogger defaultLogger].logLevel = AWSLogLevelInfo;
    return self;
}

- (void)dealloc {
    // Should never get called
    AWSLogError(@"Dealloc called on singleton AWSMobileClient.");
}

#pragma mark Singleton Methods

+ (instancetype)sharedInstance {
    static AWSMobileClient* client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}

#pragma mark AppDelegate Methods

- (BOOL)didFinishLaunching:(UIApplication *)application
               withOptions:(NSDictionary *)launchOptions {
    AWSLogDebug(@"didFinishLaunching:withOptions:");
    
    
    BOOL didFinishLaunching = [[AWSSignInManager sharedInstance] interceptApplication:application
                                                        didFinishLaunchingWithOptions:launchOptions];
    
    if (!_initialized) {
        [[AWSSignInManager sharedInstance] resumeSessionWithCompletionHandler:^(id result, AWSIdentityManagerAuthState authState, NSError *error) {
            NSLog(@"result = %@, authState = %ld, error = %@", result, (long)authState, error);
        }];
        _initialized = YES;
    }
    
    return didFinishLaunching;
}

- (BOOL)withApplication:(UIApplication *)application
                withURL:(NSURL *)url
  withSourceApplication:(NSString *)sourceApplication
         withAnnotation:(id)annotation {
    AWSLogDebug(@"withApplication:withURL:...");
    
    [[AWSSignInManager sharedInstance] interceptApplication:application
                                                    openURL:url
                                          sourceApplication:sourceApplication
                                                 annotation:annotation];
    
    if (!_initialized) {
        _initialized = YES;
    }
    
    return NO;
}

#pragma mark - AWS Methods


@end
