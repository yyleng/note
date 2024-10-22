#[derive(PartialEq, Eq, Clone, Debug)]
struct ListNode {
    val: i32,
    next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    match (l1, l2) {
        (Some(a), Some(b)) => {
            let mut stack1 = Vec::new();
            // let mut stack2 = Vec::new();
            let mut head1 = Some(a);
            // stack1.push(head1);
            while let Some(a) = head1.as_deref().unwrap().next {
                stack1.push(head1);
                head1 = Some(a);
            }
            None
        }
        (Some(a), None) | (None, Some(a)) => Some(a),
        (None, None) => None,
    }
}

// #[test]
fn main() {}
