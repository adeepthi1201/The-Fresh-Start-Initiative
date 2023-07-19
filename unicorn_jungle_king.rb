# The Fresh Start Initiative

# File: fresh_start.rb

#1
require 'csv'

#2
class FreshStart
  #3
  attr_reader :name, :start_date
  
  #4
  def initialize(name, start_date)
    @name = name
    @start_date = start_date
  end
  
  #5
  def load_data
    data = CSV.read("data/initiatives.csv", headers: true)
    data.each do |record|
      if record["Name"] == self.name
        @start_date = record["Start Date"]
        break
      end
    end
  end
  
  #6
  def start
    puts "Welcome to the #{self.name} initiative. It starts #{self.start_date}."
  end
  
  #7
  def create_goals
    goals = []
    puts "Please enter a list of goals, one at a time."
    while input = gets.chomp
      break if input == ""
      goals << input
    end
    puts goals
  end
  
  #8
  def create_tasks
    tasks = []
    puts "Enter tasks that need to be completed, one at a time. When finished leave blank."
    while input = gets.chomp
      break if input == ""
      tasks << input
    end
    tasks
  end
  
  #9
  def create_milestones
    milestones = []
    puts "Enter milestones that need to be achieved, one at a time. When finished leave blank."
    while input = gets.chomp
      break if input == ""
      milestones << input
    end
    milestones
  end
  
  #10
  def create_timeline
    timeline = []
    puts "Enter a timeline for this initiative, one at a time. When finished leave blank."
    while input = gets.chomp
      break if input == ""
      timeline << input
    end
    timeline
  end
  
  #11
  def save_data
    CSV.open('data/initiatives.csv', 'a') do |csv|
      csv << [self.name, self.start_date, goals, tasks, milestones, timeline]
    end
  end
  
  #12
  def report
    puts "The #{self.name} initiative starts #{self.start_date}. Its goals are #{self.goals}, tasks #{self.tasks}, milestones #{self.milestones}, and timeline #{self.timeline}."
  end
end

#13
def run
  puts "Enter the name of the initiative to create:"
  name = gets.chomp
  puts "Enter the start date:"
  start_date = gets.chomp
  
  #14
  fs = FreshStart.new(name, start_date)
  
  #15
  fs.load_data
  
  #16
  fs.start
  
  #17
  goals = fs.create_goals
  tasks = fs.create_tasks
  milestones = fs.create_milestones
  timeline = fs.create_timeline
  
  #18
  fs.save_data
  
  #19
  fs.report
end

#20
run