defmodule Bulls.Game do

    def new do
        %{
            secret: generateRandomSecret(MapSet.new()),
            guesses: [],
            bullsCowsList: [],
            isGameOver: false
        }
    end

    def makeGuess(st, guess) do
        if st.isGameOver do
            # TODO
            IO.puts "GAME OVER"
		st
        else

            
            if isValidGuess(guess) do
                %{
                    secret: st.secret,
                    guesses: st.guesses ++ [guess],
		    bullsCowsList: st.bullsCowsList ++ [calcBullsCows(st, guess)],
                    # TODO
                    isGameOver: isTheGameOver(st.guesses ++ [guess], st.secret)
                }

            else
                # TODO
                IO.puts "INVALID GUESS"
		st
            end
        end
    end

    def isTheGameOver(guesses, secret) do
	if (length(guesses) > 0) do
	IO.inspect "isTheGameOverFunction is called"
	IO.inspect guesses
        	String.equivalent?(Enum.at(guesses, length(guesses) - 1), secret) or (length(guesses) >= 8)
	else
		false
	end
    end

    def isNumber(str) do
        not (Integer.parse(str) == :error)
    end

    

    def isValidGuess(str) do
        len = String.length(str)
        nums = MapSet.new(String.graphemes(str))
        # checks that the length of the input is 4
        # and all digits are unique
        len === 4 && MapSet.size(nums) === 4 && List.foldr(String.graphemes(str), true, fn x, acc -> isNumber(x) && acc end)
    end

    

    def generateRandomSecret(numSet) do
        if MapSet.size(numSet) === 4 do
            Enum.join(Enum.shuffle(numSet))
        else

            # try to add a new number to the accumulating code
            # if it's a duplicate, it won't be added to the set
            generateRandomSecret(MapSet.put(numSet, to_string(Enum.random(0..9))))
        end
    end


    # assume the inputted guess is valid (4 unique digits)
    def calcBullsCows(st, guess) do
        codeList = String.graphemes(st.secret)
        guessList = String.graphemes(guess)
        bulls = 0
        cows = 0

        {bulls, cows} = if Enum.member?(codeList, Enum.at(guessList, 0)) do
                            if Enum.at(codeList, 0) === Enum.at(guessList, 0) do
                                {bulls + 1, cows}
                            else
                                {bulls, cows + 1}
                            end
                        else
                            {bulls, cows}
                        end

        {bulls, cows} = if Enum.member?(codeList, Enum.at(guessList, 1)) do
                            if Enum.at(codeList, 1) === Enum.at(guessList, 1) do
                                {bulls + 1, cows}
                            else
                                {bulls, cows + 1}
                            end
                        else
                            {bulls, cows}
                        end

        

        {bulls, cows} = if Enum.member?(codeList, Enum.at(guessList, 2)) do
                            if Enum.at(codeList, 2) === Enum.at(guessList, 2) do
                                {bulls + 1, cows}
                            else
                                {bulls, cows + 1}
                            end
                        else
                            {bulls, cows}
                        end

        

        {bulls, cows} = if Enum.member?(codeList, Enum.at(guessList, 3)) do
                            if Enum.at(codeList, 3) === Enum.at(guessList, 3) do
                                {bulls + 1, cows}
                            else
                                {bulls, cows + 1}
                            end
                        else
                            {bulls, cows}
                        end

		[bulls, cows]
    end

    

    def view(st) do

        %{
            guesses: st.guesses,
            bullsCowsList: Enum.map(st.guesses, fn x -> calcBullsCows(st, x) end),
            isGameOver: st.isGameOver
        }
    end
end

