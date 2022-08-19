function output = func_normalize01(input)
    output = (input-min(input))/(max(input)-min(input));