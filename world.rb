require 'io/console'
require_relative "voter"
require_relative "politician"

class World

  def initialize
    @voters = []
    @politicians = []
  end

  # displays a line in the interface
  def put_a_line
    puts "\n"
    puts "/\\" * 40
    puts "\n"
  end

  # main menu
  def main_menu
    put_a_line
    puts "What would you like to do?\n\n"
    puts "(C)reate"
    puts "(L)ist"
    puts "(U)pdate"
    puts "(D)elete\n\n"
    puts "(X) to exit"
    put_a_line
    main_menu_selection = STDIN.getch.downcase

    # main menu options
    case main_menu_selection
      when "c" then create
      when "l" then list
      when "u" then update
      when "d" then delete
      when "x" then exit
      else puts "Invalid entry."
        main_menu
    end
  end

  # Create menu
  def create
    put_a_line
    puts "What would you like to create?\n\n"
    puts "(P)olitician"
    puts "(V)oter\n\n"
    puts "(.) to return to the Main Menu."
    put_a_line
    create_selection = STDIN.getch.downcase
    case create_selection

      # Create a Voter
      when "v"
        puts "Voter name:"
        name = gets.chomp
        puts "Voter politics:"
        puts "(L)iberal"
        puts "(C)onservative"
        puts "(T)ea party"
        puts "(S)ocialist"
        puts "(N)eutral"
        politics = STDIN.getch.downcase
          case politics
            when "l" then politics = "Liberal"
            when "c" then politics = "Conservative"
            when "t" then politics = "Tea Party"
            when "s" then politics = "Socialist"
            when "n" then politics = "Neutral"
            else puts "Invalid option."
              create
          end
        new_record = Voter.new(name, politics)
        @voters << new_record
        put_a_line
        puts "Voter created."
        put_a_line
        main_menu

      # Create a Politican
      when "p"
        puts "Politician name:"
        name = gets.chomp
        puts "Party:"
        puts "(D)emocrat"
        puts "(R)epublican?"
        party = STDIN.getch.downcase
          case party
            when "d" then party = "Democrat"
            when "r" then party = "Republican"
            else puts "Invalid option."
              create
          end
        new_record = Pol.new(name, party)
        @politicians << new_record
        put_a_line
        puts "Politician created."
        put_a_line
        main_menu

      when "." then main_menu
      else puts "Invalid entry."
        create
      end
  end

  # List menu
  def list
    put_a_line
    puts "What would you like to list?\n\n"
    puts "(P)oliticians"
    puts "(V)oters"
    puts "(B)oth\n\n"
    puts "(.) to return to the Main Menu."
    put_a_line
    list_selection = STDIN.getch.downcase

    # List options
    case list_selection

      # List Voters
      when "v"
        puts "Voters:\n\n"
        (@voters).each do | voter |
        puts "#{voter.name.capitalize} / #{voter.politics.capitalize}"
        end

      # List Politicians
      when "p"
        puts "Politicians:\n\n"
        (@politicians).each do | politician |
        puts "#{politician.name.capitalize} / #{politician.party.capitalize}"
        end

      # List Both
      when "b"
        puts "Voters:\n\n"
        (@voters).each do | voter |
        puts "#{voter.name.capitalize} / #{voter.politics.capitalize}"
        end
        puts "\n\nPoliticians:\n\n"
        (@politicians).each do | politician |
        puts "#{politician.name.capitalize} / #{politician.party.capitalize}"
        end

      when "." then main_menu
      else puts "Invalid entry."
        list
    end
    main_menu
  end

  # Updating a record
  def update
    put_a_line
    puts "Do you want to update a... \n\n"
    puts "(V)oter"
    puts "(P)olitician\n\n"
    puts "(.) to return to main menu"
    put_a_line
    who_update = STDIN.getch.downcase
    case who_update

      # Update a voter
      when "v"
        puts "What voter would you like to update?"
        voter_update = gets.chomp
        @voters.each do | voter |
          if voter_update == voter.name
            puts "New Name?"
            voter.name = gets.chomp!
            puts "New politicial affiliation?"
            puts "(L)iberal"
            puts "(C)onservative"
            puts "(T)ea party"
            puts "(S)ocialist"
            puts "(N)eutral"
            politics = STDIN.getch.downcase
              case politics
                when "l" then voter.politics = "Liberal"
                when "c" then politics = "Conservative"
                when "t" then politics = "Tea Party"
                when "s" then politics = "Socialist"
                when "n" then politics = "Neutral"
                else puts "Invalid option."
                  update
              end
            put_a_line
            puts "Record updated."
            put_a_line
            main_menu
            else # politician_update != politician.name
              puts "Could not find a matching politician."
              update
            end
          end

      # Update a politician
      when "p"
        puts "Which politician would you like to update?"
        politician_update = gets.chomp
        @politicians.each do | politician |
          if politician_update == politician.name
            puts "New name?"
            politician.name = gets.chomp!.capitalize
            puts "New Party"
            politician.party = gets.chomp!.downcase
            put_a_line
            puts "Record updated."
            put_a_line
            main_menu
          else # politician_update != politician.name
            puts "Could not find a matching voter."
            update
          end
        end

      else puts "Invalid entry."
        list
    end
  end

  def delete
    put_a_line
    puts "Do you want to delete a... \n\n"
    puts "(V)oter"
    puts "(P)olitician\n\n"
    puts "(.) to return to main menu"
    put_a_line
    who_delete = STDIN.getch.downcase

    case who_delete
      when "v"
        puts "Which voter would you like to delete?"
        delete_voter = gets.chomp.downcase
        (@voters).each do | voter |
          if delete_voter == voter.name.downcase
            then @voters.delete(voter)
          end
          puts "Record deleted."
        end
        put_a_line
        main_menu
      when "p"
        puts "Which voter would you like to delete?"
        delete_politician = gets.chomp.downcase
        (@politicians).each do | politician |
          if delete_politician == politician.name.downcase
            then politician.delete(politician)
          end
          puts "Record deleted."
        end
        put_a_line
        main_menu
      else puts "Invalid entry."
        delete
    end

    # puts "Are you sure you want to delete #{delete_name}?"
    # are_you_sure = gets.chomp.downcase
    #
    # case are_you_sure
    # when "y"
    #
    # when "n"
    #
    # else puts "Invalid entry."
    #   are_you_sure
    # end

  end
end
world = World.new
world.main_menu
