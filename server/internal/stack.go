package internal

type Node[T any] struct {
	Value T
}

type Stack[T any] struct {
	Nodes []*Node[T]
	count int
}

func (s *Stack[T]) Push(n *Node[T]) {
	if s.count >= len(s.Nodes) {
		Nodes := make([]*Node[T], len(s.Nodes)*2)
		copy(Nodes, s.Nodes)
		s.Nodes = Nodes
	}
	s.Nodes[s.count] = n
	s.count++
}

func (s *Stack[T]) Pop() *Node[T] {
	if s.count == 0 {
		return nil
	}
	node := s.Nodes[s.count-1]
	s.count--
	return node
}

func (s *Stack[T]) IsEmpty() bool {
	return s.count == 0
}

func (s *Stack[T]) IsNotEmpty() bool {
	return s.count != 0
}
