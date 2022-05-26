function palindrome(str) {
  let newStr = str.replace(/[\W_]/g, "").toLowerCase();
  let letterArr = newStr.split("");

  while(letterArr.length > 1) {
    if(letterArr[0] !== letterArr[letterArr.length - 1]) {
      return false;
    } else if (letterArr.length > 0) {
      letterArr.pop();
      letterArr.shift();
    }
  }
  return true;
}

palindrome("eye");
