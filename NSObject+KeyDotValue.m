//
//  NSObject+KeyDotValue.m
//
//  Created by Brock Boland on 1/24/14.
//  Copyright (c) 2014 Lullabot. All rights reserved.
//

#import "NSObject+KeyDotValue.h"

@implementation NSObject (KeyDotValue)



-(void)changeValue:(id)value forProperty:(NSString *)key {
  // Make sure that the key does not begin or end with a period
  NSString *checkKey = [key stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];

  // Check if there is a dot in the key name
  NSRange firstDot = [checkKey rangeOfString:@"."];
  if (firstDot.location == NSNotFound) {
    // No dot: set the value on this object normally
    [self setValue:value forKey:checkKey];
  }
  else {
    // There is a dot: get the first part of the key name
    NSString *firstKey = [checkKey substringToIndex:firstDot.location];
    // Get the subobject at that key
    id subObject = [self valueForKey:firstKey];
    if (subObject) {
      // Use the rest of the key to call this same method on the subobject
      NSString *remainingKey = [checkKey substringFromIndex:firstDot.location+1];
      [subObject changeValue:value forProperty:remainingKey];
    }
  }
}


-(id)valueForProperty:(NSString *)key {
  // Make sure that the key does not begin or end with a period
  NSString *checkKey = [key stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];

  // Check if there is a dot in the key name
  NSRange firstDot = [checkKey rangeOfString:@"."];
  if (firstDot.location == NSNotFound) {
    // No dot: get the value from this object normally
    return [self valueForKey:checkKey];
  }
  else {
    // There is a dot: get the first part of the key name
    NSString *firstKey = [checkKey substringToIndex:firstDot.location];
    // Get the subobject at that key
    id subObject = [self valueForKey:firstKey];
    if (subObject) {
      // Use the rest of the key to call this same method on the subobject
      NSString *remainingKey = [checkKey substringFromIndex:firstDot.location+1];
      return [subObject valueForProperty:remainingKey];
    }
  }
  return nil;
}

@end
