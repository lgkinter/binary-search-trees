class Node
  attr_accessor :value, :parent_node, :left_child, :right_child

  def initialize(value)
    @value = value
    @parent_node = nil
    @left_child = nil
    @right_child = nil
  end

end

class Tree
  attr_accessor :head

  def initialize
  end

  def build_tree(arr)
    @head = Node.new(arr[0])
    traversal = @head

    (1..arr.length-1).each do |i|
      node = Node.new(arr[i])
      traversal = @head
      loop do
        if node.value >= traversal.value
          if traversal.right_child.nil?
            traversal.right_child = node
            break
          else
            traversal = traversal.right_child
          end
        else
          if traversal.left_child.nil?
            traversal.left_child = node
            break
          else
            traversal = traversal.left_child
          end
        end
      end
    end
  end

  def depth_first_search(value)
    queue = [@head]
    until queue.empty?
      traversal = queue.shift
      return traversal if value == traversal.value
      queue.unshift(traversal.right_child) unless traversal.right_child.nil?
      queue.unshift(traversal.left_child) unless traversal.left_child.nil?
    end
    return "Value not found."
  end

  def breadth_first_search(value)
    prev_level_arr = [@head]
    level_arr = []
    until prev_level_arr.all? {|item| item == "/"}
      prev_level_arr.each do |item|
        next if item == "/"
        return item if item.value == value
        level_arr.push(item.left_child.nil? ? "/" : item.left_child)
        level_arr.push(item.right_child.nil? ? "/" : item.right_child)
      end
      prev_level_arr = level_arr
      level_arr = []
    end
    return "Value not found."
  end

  def dfs_rec(value, head = @head)
    return head if value == head.value
    result = dfs_rec(value, head.left_child) unless head.left_child.nil?
    return result unless result.nil?
    result = dfs_rec(value, head.right_child) unless head.right_child.nil?
    return result unless result.nil?
  end

end

tree = Tree.new
tree.build_tree([5,7,1,15,9,2,14,8,7,3])
puts "The node with value 5 is: #{tree.breadth_first_search(5)} with value of #{tree.breadth_first_search(5).value}"
puts "The node with value 7 is: #{tree.breadth_first_search(7)} with value of #{tree.breadth_first_search(7).value}"
puts "The node with value 9 is: #{tree.breadth_first_search(9)} with value of #{tree.breadth_first_search(9).value}"
puts "The node with value 22 is: #{tree.breadth_first_search(22)}"
puts "The node with value 1 is: #{tree.depth_first_search(1)} with value of #{tree.depth_first_search(1).value}"
puts "The node with value 15 is: #{tree.depth_first_search(15)} with value of #{tree.depth_first_search(15).value}"
puts "The node with value 8 is: #{tree.depth_first_search(8)} with value of #{tree.depth_first_search(8).value}"
puts "The node with value 25 is: #{tree.depth_first_search(25)}"
puts "The node with value 2 is: #{tree.dfs_rec(2)} with value of #{tree.dfs_rec(2).value}"
puts "The node with value 14 is: #{tree.dfs_rec(14)} with value of #{tree.dfs_rec(14).value}"
puts "The node with value 3 is: #{tree.dfs_rec(3)} with value of #{tree.dfs_rec(3).value}"
puts "The node with value 27 is: #{tree.dfs_rec(27)}"
