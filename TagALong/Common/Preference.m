//
//  Preference.m
//  TagALong
//
//  Created by rabbit. on 10/01/17.
//  Copyright © 2017 hgy. All rights reserved.
//

#import "Preference.h"

@implementation Preference

+ (BOOL)getBoolean:(NSString*)strkey default:(BOOL)defalut {
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    
    if ([preferences objectForKey:strkey] == nil)
    {
        //  Doesn't exist.
        return defalut;
    }
    else
    {
        return [preferences boolForKey:strkey];
    }
}

+ (int)getInt:(NSString*)strkey default:(int)defalut {
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    
    if ([preferences objectForKey:strkey] == nil)
    {
        //  Doesn't exist.
        return defalut;
    }
    else
    {
        return (int)[preferences integerForKey:strkey];
    }
}

+ (int)getDouble:(NSString*)strkey default:(double)defalut {
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    
    if ([preferences objectForKey:strkey] == nil)
    {
        //  Doesn't exist.
        return defalut;
    }
    else
    {
        return (int)[preferences integerForKey:strkey];
    }
}

+ (NSString*)getString:(NSString*)strkey default:(NSString*)defalut {
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    
    if ([preferences objectForKey:strkey] == nil)
    {
        //  Doesn't exist.
        return defalut;
    }
    else
    {
        return [preferences stringForKey:strkey];
    }
}


+ (void)setInt:(NSString*)strkey value:(int)value {
    NSUserDefaults *show = [NSUserDefaults standardUserDefaults];
    [show setInteger:value forKey:strkey];
    [show synchronize];
}

+ (void)setDouble:(NSString*)strkey value:(double)value {
    NSUserDefaults *show = [NSUserDefaults standardUserDefaults];
    [show setDouble:value forKey:strkey];
    [show synchronize];
}

+ (void)setBoolean:(NSString*)strkey value:(BOOL)value {
    NSUserDefaults *show = [NSUserDefaults standardUserDefaults];
    [show setBool:value forKey:strkey];
    [show synchronize];
}

+ (void)setString:(NSString*)strkey value:(NSString*)value {
    NSUserDefaults *show = [NSUserDefaults standardUserDefaults];
    [show setObject:value forKey:strkey];
    [show synchronize];
}

@end
