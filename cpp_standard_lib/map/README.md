# map

```cpp
template < class Key,                                     // map::key_type
           class T,                                       // map::mapped_type
           class Compare = less<Key>,                     // map::key_compare
           class Alloc = allocator<pair<const Key,T> >    // map::allocator_type
           > class map;
```

## Map

> Maps are associative containers that store elements formed by a combination of a key value and a mapped value, following a specific order.

```cpp
// The types of key and mapped value may differ, and are grouped together in member type value_type, which is a pair type combining both:
typedef pair<const Key, T> value_type;
```

> Internally, the elements in a map are always sorted by its key.
