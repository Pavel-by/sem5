function x = task1 (n = 5)
    mRoots = roots(ones(1, n+1));
    x = real(mRoots);
    y = imag(mRoots);
    plot(x, y, "*r");
    xlabel('real');
    ylabel('imag');
endfunction
