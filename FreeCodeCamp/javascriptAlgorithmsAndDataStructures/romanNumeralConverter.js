function convertToRoman(num) {
 let numArr = num.toString().split("");
 let arrLength = numArr.length;
 let unit = numArr[arrLength -1];
 let tens = numArr[arrLength - 2];
 let hund = numArr[arrLength - 3];
 let thous = numArr[arrLength - 4];

  let romanNum = {
    zeroToNine: {
        0: "",
        1: "I",
        2: "II",
        3: "III",
        4: "IV",
        5: "V",
        6: "VI",
        7: "VII",
        8: "VIII",
        9: "IX"
    },
    tenToNinety: {
        0: "",
        1: "X",
        2: "XX",
        3: "XXX",
        4: "XL",
        5: "L",
        6: "LX",
        7: "LXX",
        8: "LXXX",
        9: "XC"
    },
    hundToNine: {
        0: "",
        1: "C",
        2: "CC",
        3: "CCC",
        4: "CD",
        5: "D",
        6: "DC",
        7: "DCC",
        8: "DCCC",
        9: "CM"
    },
    1: "M"
  }

  if(num < 10) {
    return romanNum.zeroToNine[unit];
  } else if(num > 9 && num <100) {
    return romanNum.tenToNinety[tens] + romanNum.zeroToNine[unit];
  } else if(num > 99 && num < 1000) {
    return romanNum.hundToNine[hund] + romanNum.tenToNinety[tens] + romanNum.zeroToNine[unit];
  } else if(num > 999) {
    return "M".repeat(thous) + romanNum.hundToNine[hund] + romanNum.tenToNinety[tens] + romanNum.zeroToNine[unit];
  }
}

convertToRoman(36);
