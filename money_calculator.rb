class MoneyCalculator
 	
	def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
		@ones = ones	
		@fives = fives
		@tens = tens
		@twenties = twenties
		@fifties = fifties
		@hundreds = hundreds
		@five_hundreds = five_hundreds
		@thousands = thousands	

		@return = Hash.new
		@return["rthousands"] = 0
		@return["rfive_hundreds"] = 0
		@return["rhundreds"] = 0
		@return["rfifties"] = 0
		@return["rtwenties"] = 0
		@return["rtens"] = 0
		@return["rfives"] = 0
		@return["rones"] = 0
	end
	
	def totalpay
		@totalpay = @ones.to_i*1+@fives.to_i*5+@tens.to_i*10+@twenties.to_i*20+@fifties.to_i*50+@hundreds.to_i*100+@five_hundreds.to_i*500+@thousands.to_i*1000
		return @totalpay
	end
	
	def change (price)
		r2thousands = 0
		r2five_hundreds = 0
		r2hundreds = 0
		r2fifties = 0
		r2twenties = 0
		r2tens = 0
		r2fives = 0
		r2ones = 0
		@change = @totalpay.to_i-price.to_i
		change = @change
		until change == 0 do
			if change >= 1000
				r2thousands += 1
				change -= 1000
			elsif change >= 500
				r2five_hundreds += 1
				change -= 500
			elsif change >= 100
				r2hundreds += 1
				change -= 100
			elsif change >= 50
				r2fifties += 1
				change -= 50
			elsif change >= 20
				r2twenties += 1
				change = change - 20
			elsif change >= 10
				r2tens += 1		
				change -= 10
			elsif change >= 5
				r2fives += 1	
				change -= 5
			elsif @change >= 1
				r2ones += 1
				change -= 1
			end
		end
		return {:rones => r2ones, :rfives => r2fives, :rtens => r2tens, :rtwenties => r2twenties, :rfifties => r2fifties, :rhundreds => r2hundreds, :rfive_hundreds => r2five_hundreds, :rthousands => r2thousands}
		
	end
end