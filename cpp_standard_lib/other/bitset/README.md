# bitset

```cpp
template <size_t N> class bitset;
```

## Bitset

> The class emulates an array of bool elements, but optimized for space allocation.

> Each bit position can be accessed individually by using operator[]

> Bitsets have the feature of being able to be constructed from and converted to both integer values and binary strings.

> The size of a bitset is fixed at compile-time (determined by its template parameter).

# Member functions

## count()

```cpp
size_t count() const noexcept;
```

### Count bits set

> Returns the number of bits in the bitset that are set to 1.

### Example

```cpp
    std::bitset<64> bs("110110110");
    // => 6
    cout << bs.count() << endl;
```

## size()

```cpp
constexpr size_t size() noexcept;
```

### Return size

> Returns the number of bits in the bitset.(the same as template parameter N)

### Example

```cpp
    std::bitset<64> bs("110110110");
    // => 64
    cout << bs.size() << endl;
```

## test()
