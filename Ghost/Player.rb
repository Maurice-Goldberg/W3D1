class Player
    def initialize(name)
        @name = name
    end

    attr_reader :name

    def guess
        gets.chomp.downcase
    end
end