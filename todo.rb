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
    puts 'Welcome!
      enter the letter to perform one of the following actions:
      a) Add
      u) Update
      us) Update status
      d) delete a task
      c) clear the tasks list
      s) Show

      i) import from text file
      e) export to text file

      Q) Quit the program'
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

  def update(task_number, task)
    @all_tasks.drop(task_number)
    @all_tasks[task_number]=task
  end

  def updateStatus(task_number, is_done)
    # puts "update #{task_number} #{is_done}"
    @all_tasks[task_number].is_done=is_done
  end

  def delete(task_number)
    @all_tasks.delete_at(task_number)
  end

  def clear()
    @all_tasks.clear
  end

  def show
    i=0
    for task in @all_tasks
      i+=1;
      if task.is_done
        puts "[X] task #{i}: #{task.name}"
      else
        puts "[ ] task #{i}: #{task.name}"
      end
    end
  end
end

class Task
  attr_reader :name
  attr_reader :is_done
  attr_writer :is_done

  def initialize(name,is_done=false)
    @name = name
    @is_done = is_done
  end

end

module FileManagement
  # @param [List] list
  def exportToFile(list, file_name="list.txt")
    todoFile = File.open(file_name, "w")
    for task in list.all_tasks
      todoFile.puts "#{task.name};"
    end
    todoFile.close
  end

  def importFromFile(file_name="list.txt")
    todoFile = File.open(file_name, "r")
    list = List.new
    for line in todoFile.readlines
      puts "adding task #{line}"
      list.add(Task.new(line))
    end
    list
  end
end

def run_menu(my_list)
  until (user_input=prompt.downcase) == 'q'
    case user_input
      when 'a'
        task_name = prompt(message='what is the task you would like to achieve?')
        my_list.add(Task.new(task_name))
      when 'u'
        task_number = prompt(message='which task number would you like to update?')
        task_name = prompt(message='what is the task you would like to achieve?')
        my_list.update((task_number.to_i-1), Task.new(task_name))
      when 'us'
        task_number = prompt(message='for which task number would you like to update the status?')
        is_done=""
        until is_done == "yes" || is_done == "no"
          is_done = prompt(message='is task done? yes/no').downcase
        end
        my_list.updateStatus((task_number.to_i-1),is_done=="yes"?true:false)
      when 'd'
        task_number = prompt(message='which task number would you like to delete?')
        my_list.delete((task_number.to_i-1))
      when 'c'
        my_list.clear
      when 's'
        puts 'Show the tasks'
        my_list.show
      when 'e'
        file_name = prompt(message='what is the name of the file to export to?')
        exportToFile(my_list, file_name)
      when 'i'
        file_name = prompt(message='what is the name of the file to import from?')
        my_list=importFromFile(file_name)
      else
        puts 'didn\'t understand'
        show
    end
  end
end

#ACTIONS

if __FILE__ == $PROGRAM_NAME
  include Menu
  include Promptable
  include FileManagement

  my_list = List.new
  my_list=importFromFile
  show

  run_menu(my_list)


  my_list=importFromFile
  my_list.show
  my_list.updateStatus(0,true)
  my_list.show
  puts 'Thanks for using my super software'

end


