module ApplicationHelper
    def ceil2(float,exp = 0)
      multiplier = 10 ** exp
      ((float * multiplier)).ceil.to_f/multiplier.to_f
    end
end
