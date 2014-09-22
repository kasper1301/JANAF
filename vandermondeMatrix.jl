function vandermondeMatrix(t, n)
    #=
    Calculate the Vandermonde matrix of order n.
    Input:
        t:  The variable as a one-dimensional array
        n:  The order
    Output:
        The Vandermonde matrix:
        [1  t1  t1^2    ... t1^n
         1  t2  t2^2    ... t2^n
         :  :   :           :
         1  tm  tm^2        tm^n]
    =#
    tMatrix = ones(length(t), n+1)                       # Initialize the matrix
    for i = 1:n
        tMatrix[:,i+1] = t.^i                               # Fill in the matrix
    end
    return tMatrix
end
