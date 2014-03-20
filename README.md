**Note:** When I wrote this category, I did not know about [`setValue:forKeyPath:`](https://developer.apple.com/library/mac/documentation/cocoa/reference/foundation/Protocols/NSKeyValueCoding_Protocol/Reference/Reference.html#//apple_ref/occ/instm/NSObject/setValue:forKeyPath:) and [`valueForKey:`](https://developer.apple.com/library/mac/documentation/cocoa/reference/foundation/Protocols/NSKeyValueCoding_Protocol/Reference/Reference.html#//apple_ref/occ/instm/NSObject/valueForKey:) in [NSKeyValueCoding](https://developer.apple.com/library/mac/documentation/cocoa/reference/foundation/Protocols/NSKeyValueCoding_Protocol/Reference/Reference.html). Those should probably be used in most cases, but this category might still be useful in some conditions.

----

Adds two methods to get and set property values using dot-separated keys. See the [header file comments for details](NSObject%2BKeyDotValue.h).

Both methods allow the key to be a dot-separated path to a property. For example, let's say you have a card object, which has a contact property, which has firstName (NSString) and profileImage (UIImage) properties. All of these keys would be valid in that case:

* card
* card.contact
* card.contact.firstName
* card.contact.profileImage
* card.contact.profileImage.size

# Usage

```objc
// Set a new image
[card changeValue:newImage forProperty:@"contact.profileImage"];

// Get the first name
[card valueForProperty:@"contact.firstName"];
```

These are not real-world examples, of course, because one would simply use `card.contact.profileImage` and `card.contact.firstName` to access these properties directly. The more valuable use case is when the get or set is further removed from the original object. For example, imagine a UITableViewCell subclass that has two properties:

```objc
@property (nonatomic, weak) Card *card;
@property (nonatomic, strong) NSString *fieldKey;
```

Instances of that subclass now know, "This is the object that has the data (`card`) and this is the key to use to get the data to display (`fieldKey`)." This is a little more useful:

```objc
// In a cell setup method:
NSString *valueToDisplay = [self.card valueForProperty:self.fieldKey];
```

Thus, the cell subclass doesn't need to know a whole lot about the details of the Card object in order to get values for display (or change them based on user input).

# Limitations

This will only work with properties that key value coding-compliant objects. For example, the key "card.contact.profileImage.size.width" cannot be used because the UIImage property `size` is a `CGSize`, which is not key value coding-compliant for the key `width`.
