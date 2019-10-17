require "byebug"

class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        new_arr = []
        self.my_each do |ele|
            new_arr << ele if prc.call(ele)
        end
        new_arr
    end

    def my_reject(&prc)
        new_arr = []
        self.my_each do |ele|
            new_arr << ele if !prc.call(ele)
        end
        new_arr
    end

    def my_any?(&prc)
        self.my_each { |ele| return true if prc.call(ele) }
        false
    end

    def my_all?(&prc)
        self.my_each { |ele| return false if !prc.call(ele) }
        true
    end

    def my_flatten
        return self if self.my_all? { |ele| !ele.is_a?(Array) }

        new_array = []
        self.my_each do |ele|
            if ele.is_a?(Array)
                new_array += ele.my_flatten
            else 
                new_array << ele
            end
        end

        new_array
    end

    # def my_zip(*splt)
    #     if splt.length < self.length
    #         return nil
    #     end

    #     splt.my_each do |ele|
    # end

    def my_zip(*splt)
        zipped_array = []
        (0...self.length).to_a.my_each do |i|
            subarray = Array.new
            subarray << self[i]
            splt.my_each { |arg| subarray << arg[i] }
            zipped_array << subarray
        end
        zipped_array
    end

    def my_rotate(num = nil)
        if num == nil
            self.push(self.shift)
        elsif num < 0 || num > 0
            num.times { self.push(self.shift)  }
            self
        else
            self
        end
    end

    def my_join(char)
        new_str = ""
        (0...self.length).to_a.my_each { |i|
            if i == self.length-1
                new_str << self[i]
            else  
                new_str << (self[i] + char)
            end
        }
        new_str
    end

    def my_reverse
        new_array = []
        i = self.length-1
        while i >= 0
            new_array << self[i]
            i -= 1
        end
        new_array
    end
end