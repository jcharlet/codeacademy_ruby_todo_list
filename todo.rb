# Core User Stories
#
# As a user I can create a todo list
# As a user I can add tasks to the todo list
# As a user I can see all the tasks in a list
# As a user I can manipulate the todo list through a menu

# Secondary User Stories
#
# As a user I can open a list from a text file
# As a user I can save a list to a text file
# As a user I can delete a task
# As a user I can update a task

# Reach User Stories
#
# As a user I can set a task status
# As a user I can toggle a task status as complete or incomplete

# CLASSES

module Menu
  def menu
    puts "Welcome!
      press a number to perform one of the following actions:
      1) Add'
      2) Show
      Q) Quit the program"


  end

  def show
    menu
  end

end

module Promptable
  def prompt(message='What would you like to do?', symbol= ':>')
    puts message
    print symbol
    gets.chomp
  end
end

class List

  attr_reader :all_tasks

  def initialize
    @all_tasks = []
  end

  def add(task)
    @all_tasks << task
  end

  def show
    i=0
    for task in @all_tasks
      i+=1;
      puts "task #{i}: #{task.name}"
    end
  end
end

class Task
  attr_reader :name

  def initialize(name)
    @name = name
  end

end
# Task Class
# Create a task item


#ACTIONS

if __FILE__ == $PROGRAM_NAME
  include Menu
  include Promptable
  my_list = List.new
  show

  user_input=
  until (user_input=prompt().upcase) == 'Q'
    case user_input
      when '1'
        task_name = prompt(message='what is the task you would like to achieve?')
        my_list.add(Task.new(task_name))
      when '2'
        puts 'Show the tasks'
        my_list.show
      else
        puts 'didn\'t understand'
        show
    end
  end

  puts 'Thanks for using my super software'

end


