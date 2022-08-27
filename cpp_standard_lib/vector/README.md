# vector

> template < class T, class Alloc = allocator<T> > class vector;

Vectors are sequence containers representing arrays that can change in size.
• Vector 序列容器表示可以改变大小的数组。

Just like arrays, vectors use contiguous storage locations for their elements, which means that their elements can also be accessed using offsets on regular pointers to its elements, and just as efficiently as in arrays.
But unlike arrays, their size can change dynamically, with their storage being handled automatically by the container.
• 就像数组一样，Vector 使用连续的内存空间存储元素，这意味着也可以使用指向其元素的常规指针上的偏移量来访问它们的元素，并且与在数组中一样有效。
• 但与数组不同的是，它们的大小可以动态变化，它们的存储由容器自动处理。

Internally, vectors use a dynamically allocated array to store their elements.
This array may need to be reallocated in order to grow in size when new elements are inserted, which implies allocating a new array and moving all elements to it.
This is a relatively expensive task in terms of processing time, and thus, vectors do not reallocate each time an element is added to the container.
• 在内部，Vector 使用动态分配的数组来存储它们的元素。
• 这个数组可能需要重新分配，以便在插入新元素时增加大小，这意味着分配一个新数组并将所有元素移动到它。
• 就处理时间而言，这是一项相对昂贵的任务，因此，Vector 不会在每次将元素添加到容器时重新分配。

Instead, vector containers may allocate some extra storage to accommodate for possible growth, and thus the container may have an actual capacity greater than the storage strictly needed to contain its elements (i.e., its size).
Libraries can implement different strategies for growth to balance between memory usage and reallocations, but in any case, reallocations should only happen at logarithmically growing intervals of size so that the insertion of individual elements at the end of the vector can be provided with amortized constant time complexity (see push_back).
• 相反，Vector 容器可能会分配一些额外的存储空间来适应可能的增长，因此容器的实际容量可能大于包含其元素所严格需要的存储空间（即其大小）。
• 库可以实现不同的增长策略以平衡内存使用和重新分配，但无论如何，重新分配应该只发生在对数增长的大小间隔上，以便可以为向量末尾的单个元素插入提供摊销常数时间复杂性（见推回）。

Therefore, compared to arrays, vectors consume more memory in exchange for the ability to manage storage and grow dynamically in an efficient way.
• 因此，与数组相比，Vector 消耗更多内存以换取管理存储和以有效方式动态增长的能力。

Compared to the other dynamic sequence containers (deques, lists and forward_lists), vectors are very efficient accessing its elements (just like arrays) and relatively efficient adding or removing elements from its end.
For operations that involve inserting or removing elements at positions other than the end, they perform worse than the others, and have less consistent iterators and references than lists and forward_lists.
• 与其他动态序列容器（双端队列、列表和前向列表）相比，Vector 非常有效地访问其元素（就像数组一样）并且从其末端添加或删除元素相对有效。
• 对于涉及在结尾以外的位置插入或删除元素的操作，它们的性能比其他操作更差，并且迭代器和引用的一致性不如列表和前向列表。

# properties

- Sequence
  Elements in sequence containers are ordered in a strict linear sequence.
  Individual elements are accessed by their position in this sequence.
  • 序列容器中的元素按严格的线性顺序排序。
  • 单个元素通过它们在此序列中的位置进行访问。

- Dynamic array
  Allows direct access to any element in the sequence, even through pointer arithmetics, and provides relatively fast addition/removal of elements at the end of the sequence.
  • 允许直接访问序列中的任何元素，甚至通过指针算术，并在序列末尾提供相对快速的元素添加/删除。

- Allocator-aware
  The container uses an allocator object to dynamically handle its storage needs.
  • 容器使用分配器对象来动态处理其存储需求。

# Template parameters

- T(Type of the elements)
  Only if T is guaranteed to not throw while moving, implementations can optimize to move elements instead of copying them during reallocations.
  • 只有当 t 保证在移动时不会抛出，实现才能优化移动元素而不是在重新分配期间复制它们。

- Alloc
  Type of the allocator object used to define the storage allocation model. By default, the allocator class template is used, which defines the simplest memory allocation model and is value-independent.
  • 用于定义存储分配模型的分配器对象的类型。默认使用分配器类模板，它定义了最简单的内存分配模型，并且与值无关。

# Public member functions

---

## constructor()

**default**:

- vector<int> v;(初始化一个空的 vector)
  **fill**
- vector<int>v1(10);(初始化一个 size 和 capacity 为 10 的 vector, 默认值为 0 )
- vector<int>v2(10,1);(初始化一个 size 和 capacity 为 10 的 vector, 默认值为 1 )
  **range**
- vector<int>v3(v2.begin()+1,v2,end());(使用 vector v2 的局部范围来对 v3 进行初始化)
  **copy**
- vector<int>v4(v3);(使用 vector v3 来对 v4 进行初始化)
  **move**
- vector<int>v5(std::move(v4));(vector v4 中的数据会被移动到 v5 中来)
  **initializer_list**
  ```cpp
  initializer_list<int> il = {1, 2, 3};
  vector<int> v(il);
  // or the same
  vector<int> v{1,2,3}
  ```

---

## assign()

```cpp
// range (1) -> [first, end)
template <class InputIterator>
  void assign (InputIterator first, InputIterator last);
// fill (2)
void assign (size_type n, const T& val);
// initializer list (3)
void assign (initializer_list<T> il);
```

### Assign vector content

> Assigns new contents to the vector, replacing its current contents, and modifying its size accordingly.

```txt
 In range (1), the new contents are elements constructed from each of the elements in the range between first and last, in the same order.
 In fill (2), the new contents are n elements, each initialized to a copy of val.
 In initializer list (3), the new contents are copies of the values passed as initializer list, in the same order.
```

> This causes an automatic reallocation of the allocated storage space if and only if the new vector size surpasses the current vector capacity.

### Example

```cpp
 vector<int> v{1,2,3};
 vector<int> v1{4,5,6,7,8,9};
 // range (1) => content: [2,3], capacity: 6, size: 2
 v1.assign(v.begin()+1, v.end());
 // fill (2) => content: [1,1,1,1,1,1,1,1,1,1], capacity: 10, size: 10
 v1.assign(10,1);
 // initializer list (3) => content: [1,2,3,4,5], capacity: 6, size: 5
 v1.assign({1,2,3,4,5})
```

---

## size()

```cpp
size_type size() const noexcept;
```

### Return size

> Returns the number of elements in the vector.

> This is the number of actual objects held in the vector, which is not necessarily equal to its storage capacity.

### Return Value

> The number of elements in the container.

### Example

```cpp
    vector<int> v{1,2,3};
    // => 3
    cout << v.size() << endl;
```

---

## reserve()

```cpp
void reserve (size_type n);
```

### Request a change in capacity

> Requests that the vector capacity be at least enough to contain **n** elements.

> This function has no effect on the vector size and cannot change its elements.

### Return Value

> If the size requested is greater than the vector::max_size(), a **length_error** exception is thrown.

> **bad_alloc** exception is thrown if the allocation request does not succeed

### Example

```cpp
  vector<int> v;
  v.assign({1, 2, 3});
  try {
    v.reserve(10);

  } catch (bad_alloc& e) {
    cout << e.what() << endl;
  }
  cout << v.size() << endl;
  cout << v.capacity() << endl;
  for (const auto& i : v) {
    cout << i << " ";
  }
  cout << endl;

```

---

## capacity()

```cpp
size_type capacity() const noexcept;
```

### Return size of allocated storage capacity

> Returns the size of the storage space currently allocated for the vector.

> This capacity is not necessarily equal to the vector size. It can be equal or greater.

> The limitation on the size of a vector is given by vector::max_size().

### Return value

> The size of the currently allocated storage capacity in the vector

### Example

```cpp
    vector<int> v;
    v.reserve(10);
    v.assign({1,2,3});
    // => 3
    cout << v.size() << endl;
    // => 10
    cout << v.capacity() << endl;
```

---

## at()

```cpp
reference at (size_type n);
const_reference at (size_type n) const;
```

### Access element

> Returns a reference to the element at position **n** in the vector.

> The function automatically checks whether **n** is within the bounds of valid elements in the vector, throwing an **out_of_range** exception if it is not.

> Notice that the first element has a position of **0** (not 1), the same as operator [].

### Return value

> The element at the specified position in the container.

> If the vector object is const-qualified, the function returns a const reference. Otherwise, it returns a reference.

### Example

```cpp
    vector<int> v;
    v.reserve(2);
    v.assign({1,2,3,4,5});
    for(int i = 0; i < v.capacity()+1; i++){
        try {
            cout << v.at(i) << std::endl;
        }catch(std::out_of_range e){
            cout << e.what() << std::endl;
        }
    }
```

---

## front()

```cpp
reference front();
const_reference front() const;
```

### Access first element

> Returns a reference to the first element in the vector.

> Calling this function on an empty container causes undefined behavior.

### Return value

> A reference to the first element in the vector container.

> If the vector object is const-qualified, the function returns a const reference. Otherwise, it returns a reference.

### Example

```cpp
vector<int> v{1,2,3};
if(!v.empty()){
    // => 1
    cout << v.front() << endl;
}
```

---

## back()

```cpp
reference back();
const_reference back() const;
```

### Access last element

> Returns a reference to the last element in the vector.

> Calling this function on an empty container causes undefined behavior.

### Return value

> A reference to the last element in the vector.

> If the vector object is const-qualified, the function returns a const reference. Otherwise, it returns a reference.

### Example

```cpp
    vector<int> v;
    v.reserve(2);
    v.assign({1,2,3,4,5});
    // must check whether the vector is empty to avoid undefined behavior
    if(!v.empty()){
        cout << v.back() << endl;
    }
```

---

## empty()

```cpp
bool empty() const noexcept;
```

### Test whether vector is empty

> Returns whether the vector is empty (i.e. whether its size is 0).

### Return Value

> true if the container size is 0, false otherwise.

---

## clear()

```cpp
void clear() noexcept;
```

### Clear content

> Removes all elements from the vector, leaving the container with a size of 0.

> A reallocation is not guaranteed to happen, and the vector capacity is not guaranteed to change.

---

## begin()

```cpp
iterator begin() noexcept;
const_iterator begin() const noexcept;
```

### Return iterator to beginning

> Returns an iterator pointing to the first element in the vector.

> If the container is empty,the return value of begin() is equals to the return value of end(), use the returned iterator value leading to segmentation fault.

### Return Value

> An iterator to the beginning of the vector container.

> If the vector object is const-qualified, the function returns a const iterator. Otherwise, it returns an iterator.

### Example

```cpp
    vector<int> v;
    v.reserve(2);
    // => ok
    if (v.begin() == v.end()){
        cout << "ok" << endl;
    }
    // correct
    for(auto i = v.begin(); i != v.end(); ++i) {
        cout << *i << endl;
    }
    v.assign({1,2,3,4,5});
    // correct
    for(auto i = v.begin(); i != v.end(); ++i) {
        cout << *i << endl;
    }
```

---

## end()

```cpp
iterator end() noexcept;
const_iterator end() const noexcept;
```

### Return iterator to end

> Returns an iterator that does not point to any element.

> If the container is empty, this function returns the same as vector::begin().

### Return Value

> An iterator to the element past the end of the sequence.

> If the vector object is const-qualified, the function returns a const iterator. Otherwise, it returns an iterator.

---

## data()

```cpp
T* data() noexcept;
const T* data() const noexcept;
```

### Access data

> Returns a direct pointer to the memory array used internally by the vector to store its owned elements.

> Notice that use this to insert value can't change vector size.

### Return value

> A pointer to the first element in the array used internally by the vector.

> If the vector object is const-qualified, the function returns a pointer to const T. Otherwise, it returns a pointer to T.

## Example

```cpp
  vector<int> v;
  try {
    v.reserve(5);

  } catch (bad_alloc& e) {
    cout << e.what() << endl;
  }

  // => 0
  cout << v.size() << endl;
  // => 5
  cout << v.capacity() << endl;
  v.push_back(1);
  // => 1
  cout << v.size() << endl;
  // => 5
  cout << v.capacity() << endl;

  auto pointer = v.data();
  pointer[0] = 4;
  ++pointer;
  pointer[1] = 2;
  for(int i=0;i<v.size();++i) {
    // => 4
    cout << v[i] << endl;
  }
  for(int i=0;i<v.capacity();++i) {
    // => 4,0,2,0,0
    cout << v[i] << endl;
  }
```

---

## emplace_back()

```cpp
template <class... Args>
  void emplace_back (Args&&... args);
```

### Construct and insert element at the end

> Inserts a new element at the end of the vector. This new element is constructed in place using **args** as the arguments for its constructor.

### Parameters

#### args

> Arguments forwarded to construct the new element.

### Return value

> **bad_alloc** exception is thrown if the allocation request does not succeed

### Example

```cpp
class Test {
    private:
        std::string str;
        int num;
    public:
        Test(std::string str, int num) : str(str), num(num) {
            cout << "Test constructor" << endl;
        }
        Test(const Test& other) : str(other.str), num(other.num) {
            cout << "Test copy constructor" << endl;
        }
        Test(Test&& other) : str(other.str), num(other.num) {
            cout << "Test move constructor" << endl;
        }
        virtual ~Test() {
            cout << "Test destructor" << endl;
        }
};

int main() {
  vector<Test> v;
  try {
    v.reserve(5);

  } catch (bad_alloc& e) {
    cout << e.what() << endl;
  }

  cout << v.size() << endl;
  cout << v.capacity() << endl;
  // right value
  // => Test constructor
  // => Test move constructor
  // => Test destructor
  v.emplace_back(Test("test", 1));
  cout <<"-------------------" << endl;
  // right value (recommended) (compared to push_back, push_back has no this function)
  // => Test constructor
  v.emplace_back("test", 1);
  cout <<"-------------------" << endl;
  // => Test constructor
  Test t("test", 1);
  // left value
  // => Test copy constructor
  v.emplace_back(t);
  cout <<"-------------------" << endl;
  // left value (recommended)
  // Test move constructor
  v.emplace_back(std::move(t));
  cout <<"-------------------" << endl;
  return 0;
}
```

---

## push_back()

```cpp
void push_back (const value_type& val);
void push_back (value_type&& val);
```

### Add element at the end

> Adds a new element at the end of the vector. The content of **val** is copied (or moved) to the new element.

### Return value

> **bad_alloc** exception is thrown if the allocation request does not succeed

### Example

```cpp
class Test {
    private:
        std::string str;
        int num;
    public:
        Test(std::string str, int num) : str(str), num(num) {
            cout << "Test constructor" << endl;
        }
        Test(const Test& other) : str(other.str), num(other.num) {
            cout << "Test copy constructor" << endl;
        }
        Test(Test&& other) : str(other.str), num(other.num) {
            cout << "Test move constructor" << endl;
        }
        virtual ~Test() {
            cout << "Test destructor" << endl;
        }
};

int main() {
  vector<Test> v;
  try {
    v.reserve(5);

  } catch (bad_alloc& e) {
    cout << e.what() << endl;
  }

  cout << v.size() << endl;
  cout << v.capacity() << endl;
  // right value
  // => Test constructor
  // => Test move constructor
  // => Test destructor
  v.push_back(Test("test", 1));
  cout <<"-------------------" << endl;
  // => Test constructor
  Test t("test", 1);
  // left value
  // => Test copy constructor
  v.push_back(t);
  cout <<"-------------------" << endl;
  // left value (recommended)
  //Test move constructor
  v.push_back(std::move(t));
  cout <<"-------------------" << endl;
  return 0;
}
```

---

## erase()

```cpp
iterator erase (const_iterator position);
iterator erase (const_iterator first, const_iterator last);
```

### Erase elements

> Removes from the vector either a single element (position) or a range of elements ([first,last)).

### Return value

> An iterator pointing to the new location of the element

> This is the container end() if the operation erased the last element in the sequence.

### Example

```cpp
    vector<int> v{1, 2, 3, 4, 5};
    for (auto i : v) {
        // => 1,2,3,4,5
        cout << i << endl;
    }

    // => 5
    cout << "size: " << v.size() << endl;
    // => 5
    cout << "cap: " << v.capacity() << endl;
    cout << "-------------" << endl;

    // => 0x1234567
    cout << (v.begin() + 1).base() << endl;
    // => 0x1234567
    cout << v.erase(v.begin() + 1).base() << endl;

    for (auto i : v) {
        // => 1,3,4,5
        cout << i << endl;
    }
    // => 4
    cout << "size: " << v.size() << endl;
    // => 5
    cout << "cap: " << v.capacity() << endl;
```

---

## max_size()

```cpp
size_type max_size() const noexcept;
```

### Return maximum size

> Returns the maximum number of elements that the vector can hold.

### Return value

> The maximum number of elements a vector container can hold as content.

---

## pop_back()

```cpp
void pop_back();
```

### Delete last element

> Removes the last element in the vector, effectively reducing the container size by one.

---

## resize()

```cpp
void resize (size_type n);
void resize (size_type n, const value_type& val);
```

### Change size

> Resizes the container so that it contains **n** elements.

### Example

```cpp
  vector<int> v;
  // => 0
  cout << v.size() << endl;
  v.resize(5);
  // => 5
  cout << v.size() << endl;
```

---

## shrink_to_fit()

```cpp
void shrink_to_fit();
```

### Shrink to fit

> Requests the container to reduce its capacity to fit its size.

> This may cause a reallocation, but has no effect on the vector size and cannot change its elements.

### Example

```cpp
  vector<int> v{1, 2, 3};
  v.reserve(10);
  // => 3
  cout << v.size() << endl;
  // => 10
  cout << v.capacity() << endl;
  v.shrink_to_fit();
  // => 3
  cout << v.size() << endl;
  // => 3
  cout << v.capacity() << endl;
```

## swap()

```cpp
void swap (vector& x);
```

### Swap content

> Exchanges the content of the container by the content of x, which is another vector object of the same type.

### Example

```cpp
  vector<int> v{1, 2, 3};
  vector<int> v2(5,10);
  // std::swap(v,v2); is ok too
  v.swap(v2);
  for (auto i : v) {
    // => 10,10,10,10,10
    cout << i << " ";
  }
  cout << endl;
  for (auto i : v2) {
    // => 1,2,3
    cout << i << " ";
  }
  cout << endl;
```
