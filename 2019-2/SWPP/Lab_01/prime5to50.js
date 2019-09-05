function wannaGoHome(){
    var str = ""
    for(var n = 5; n <= 50; n++){
        var isPrime = true;
        for(var probe = 2; probe < n; probe++)
            if(n % probe == 0)
                isPrime = false;

        if(isPrime)
            str += n + " is a prime number</br>"
    }

    return str
}
