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

- (constructor)
