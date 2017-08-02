class Node

	attr_accessor :value, :parent, :small_child, :big_child, :count

	def initialize(data = nil, parent = nil)
		@value = data
		@count = 1
		@parent = parent
		@small_child = nil
		@big_child = nil
	end

	#shows the node along with parent and children.
	def show
		puts "I am #{self}"
		puts "My value is #{@value}(#{@count})"
		puts "My parent is #{@parent.value}" if @parent != nil
		puts "My small child is #{@small_child.value}" if @small_child != nil
		puts "my big child is #{@big_child.value}" if @big_child != nil
		puts ""
		@small_child.show if @small_child != nil
		@big_child.show if @big_child != nil
	end


end

class BinaryTree

	attr_accessor :root_node

	def initialize( array = nil)
		@root_node
		build_tree(array) if array != nil
	end

	#builds a binary tree from a given array
	def build_tree(array)
		@root_node = Node.new(array[array.length / 2])
		array[array.length / 2] = nil
		counter = 0
		until counter == array.length
			set_value(array[counter], @root_node) if array[counter] != nil
			counter += 1
		end

	end

	#makes and sets the values for nodes in the binary tree.
	def set_value(input, root)
		return root = Node.new(input) if root == nil

		case input <=> root.value
		when -1
			return root.small_child = Node.new(input, root) if root.small_child == nil
			set_value(input, root.small_child)
		when 1
			return root.big_child = Node.new(input, root) if root.big_child == nil
			set_value(input, root.big_child)
		when 0
			root.count += 1
		end
	end

	def breadth_first_search(target)
		current = @root_node
		to_search = []
		until current == nil
			return current if current.value == target
			to_search << current.small_child if current.small_child != nil
			to_search << current.big_child if current.big_child != nil
			current = to_search.first
			to_search.shift
		end
		nil
	end

	def depth_first_search(target)
		current = @root_node
		to_search = []
		until current == nil
			return current if current.value == target
			to_search << current.big_child if current.big_child != nil
			to_search << current.small_child if current.small_child != nil
			current = to_search.last
			to_search.pop
		end
		nil
	end

	#depth first search that is recursive
	def dfs_rec(target, root = @root_node)
		location = dfs_rec(target, root.small_child) if root.small_child != nil
		return location if location != nil
		return root if root.value == target
		location = dfs_rec(target, root.big_child) if root.big_child != nil
		location
	end

	#shows the tree values. 
	def show_tree
		@root_node.show
	end


end

tree = BinaryTree.new

test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

test_array2 = [2,5,8,65,49,897,65,45,8,98,15,651,654,1653,879,615,1958,84,651,51,45,21,51,51,6584,321,654,132,654,321,6584,1,6,8,654,5]

tree.build_tree(test_array2)


tree.show_tree

puts tree.dfs_rec(321)