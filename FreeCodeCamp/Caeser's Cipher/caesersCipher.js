function rot13(str) {
  const cipherBet = "NOPQRSTUVWXYZABCDEFGHIJKLM";
  const alphaBet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  return str.replace(/[A-Z]/g, letter => cipherBet[alphaBet.indexOf(letter)])
}

rot13("SERR PBQR PNZC");
