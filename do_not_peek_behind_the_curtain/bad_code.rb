module BadCode
  module_function

  def show_expected_results(comments)
    show_list(top_level_comments(comments), comments)
  end

  def show_list(comments, all_comments, indent = "")
    puts "#{indent}<ul>"
    comments.each do |comment|
      print "#{indent}  <li>#{comment.nesting}"
      children = child_comments(comment, all_comments)
      unless children.empty?
        puts
        show_list(children, all_comments, indent + "    ")
        print "#{indent}  "
      end
      puts "</li>"
    end
    puts "#{indent}</ul>"
  end

  def top_level_comments(comments)
    comments.reject(&:parent_id)
  end

  def child_comments(parent, comments)
    comments.select { |comment|
      comment.nesting =~ /\A#{Regexp.escape(parent.nesting)}\.\d+\z/
    }
  end
end
