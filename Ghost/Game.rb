class Game
    def initialize(player_1, player_2)
        @current_player = player_1
        @previous_player = player_2
        @fragment = ""
        @losses = { player_1 => 0, player_2 => 0 }
        @dictionary = Set.new File.read("words.txt").split("\n")
        @round_over = false
    end

    attr_reader :current_player, :previous_player

    def next_player!
        @current_player, @previous_player = @previous_player, @current_player
    end

    def valid_play?(string)
        alphabet = ("a".."z").to_a
        if string.length > 1
            puts "\nYou may only enter one letter at a time...\n\n"
            false
        elsif !alphabet.include?(string)
            puts "\nPlease enter a valid letter in the alphabet...\n\n"
            false
        elsif @dictionary.select { |word| word[0..@fragment.length] == @fragment + string}.empty?
            puts "\nThere's no word in the dictionary that could be created by adding '#{string}'...\n\n"
            false
        else
            true
        end
    end

    def lose(player)
        puts "\n#{player.name} lost the round with '#{@fragment}'! :(\n"
        # puts "New game?"
        # input = gets.chomp
        # if input == "Yes"
    end

    def take_turn(player)
        puts "\n#{player.name}... enter a letter...\n"
        input = player.guess
        if valid_play?(input)
            if @dictionary.include?(@fragment + input)
                @fragment += input
                print "\n\nThe fragment is... '#{@fragment}'\n"
                return true
            else
               @fragment += input
               puts "\n\nThe fragment is now... '#{@fragment}'\n"
               next_player!
               return false
            end
        else
            take_turn(player)
        end
    end

    def record(player)
        case @losses[player]
        when 0
            puts "\n#{player.name}: \n"
        when 1
            puts "\n#{player.name}: G\n"
        when 2
            puts "\n#{player.name}: GH\n"
        when 3
            puts "\n#{player.name}: GHO\n"
        when 4
            puts "\n#{player.name}: GHOS\n"
        when 5
            puts "\n#{player.name}: GHOST\n"
        end
    end

    def play_round
        until @round_over
            @round_over = take_turn(@current_player)
        end
        lose(@current_player)
        @losses[@current_player] += 1

        #make round ready to start again
        @round_over = false
        @fragment = ""
    end

    def display_standings
        record(@current_player)
        record(@previous_player)
    end

    def game_over
        @losses[@current_player] == 5 ? loser = @current_player.name : loser = @previous_player.name
        puts "\nGAME OVER. #{loser} lost... x__x\n"
    end

    def run 
        until @losses[@current_player] == 5 || @losses[@previous_player] == 5
            play_round
            display_standings
        end
        game_over
    end
end


player_1, player_2 = Player.new("Maurice"), Player.new("Filip")
ghost = Game.new(player_1, player_2)
ghost.run