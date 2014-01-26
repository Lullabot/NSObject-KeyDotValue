Adds two methods to get and set property values using dot-separated keys. See the [header file comments for details](NSObject%2BKeyDotValue.h).

Both methods allow the key to be a dot-separated path to a property. For example, let's say you have a card object, which has a contact property, which has firstName (NSString) and profileImage (UIImage) properties. All of these keys would be valid in that case:

* card
* card.contact
* card.contact.firstName
* card.contact.profileImage
* card.contact.profileImage.size

# Limitations

This will only work with properties that key value coding-compliant objects. For example, you cannot use the key "card.contact.profileImage.size.width" because the UIImage property `size` is a `CGSize`, which is not key value coding-compliant for the key `width`.
