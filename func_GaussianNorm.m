function output = func_GaussianNorm(input)
    output = (input-mean(input))/std(input);