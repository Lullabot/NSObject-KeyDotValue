//
//  NSObject+KeyDotValue.h
//
//  Created by Brock Boland on 1/24/14.
//  Copyright (c) 2014 Lullabot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KeyDotValue)

/**
 * Similar to the setValue:forKey: method, but the key can contain dot-separated property names.
 * For example, if an object has a property called contact, and that contact object has a profileImage
 * property, the image could be changed by calling:
 * [someObj changeValue:newImage forProperty:@"contact.profileImage"];
 *
 * The text up to the first period is broken off the of the key, and used to call valueForKey: on self.
 * If a value is returned, then the changeValue:forProperty: method is called on that sub-object with
 * the remainder of the key—that is, the text after the first period. This happens recursively, so that
 * keys with many periods are handled.
 *
 * If the key does NOT contain a period, setValue:forKey: is called with the given value and key. This
 * is the exit case for the recursion.
 *
 * @param value New value for the property
 * @param key Period-seperated keys
 */
-(void)changeValue:(id)value forProperty:(NSString *)key;


/**
 * Similar to the valueForKey: method, but the key can contain dot-separated property names.
 * For example, if an object has a property called contact, and that contact object has a profileImage
 * property, the image could be accessed by calling:
 * UIImage *profileImg = [someObj valueForProperty:@"contact.profileImage"];
 *
 * Like changeValue:forProperty: this is called recursively as it works through periods in the key name.
 *
 * If the key does NOT contain a period, valueForKey: is called with the given key. This
 * is the exit case for the recursion.
 *
 * @param key Period-seperated keys
 * @return The value for the requested property
 */
-(id)valueForProperty:(NSString *)key;


@end
