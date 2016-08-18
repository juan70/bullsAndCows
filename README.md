Bulls and Cows
==============

Table of contents
 - [Introduction](#introduction)
 - [Building and running](#building-and-running)
 - [Rules](#rules)
 - [Example session](#example-session)
 - [Other](#other)


## Introduction

Many years ago, I wrote a Korn Shell version of Mastermind on a UNIX machine at work... Yeah, one of those days where there was nothing to do because we are so good at what we do that everything works smoothly for days, without any kind of bug. My version of Mastermind was for the console, just text, and numbers instead of colored pegs. I think I lost the source code, or maybe it is at home somewhere on a DVD...

I saw this Wikipedia entry: [Bulls and Cows](https://en.wikipedia.org/wiki/Bulls_and_Cows). It looks like a simpler version of Mastermind, and I said "Hey, let's do this".


## Building and running

A basic gradle script is provided:
```
$ cd bullsAndCows
$ gradle build
$ java -jar build/libs/bullsAndCows.jar
```

Alternatively, bu hand:
```
$ cd bullsAndCows/src/main/java
$ javac MainCLI.java
$ jar cfe bullsAndCows.jar MainCLI *.class
$ java -jar build/libs/bullsAndCows.jar
```


## Rules

The rules are simple:

 1. The machine defines a 4-digits number. All digits must be different.
 2. The player types 4 digits.
 3. The machine gives feedback:
    - A digit is correct and at the correct place: 1 bull
    - A digit is correct but not at the correct place: 1 cow
    - A digit is incorrect (whatever the place): nothing, that is 0 bull and 0 cow.
 4. Loop over points 2 and 3 until the player guesses the correct number or resigns...


## Example session

```
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Bulls and Cows: Guess the 4-digits number.
Type "quit" at any moment to leave the game.
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
1. Enter a 4-digits number: 1234
0 bulls, 3 cows

2. Enter a 4-digits number: 5678
1 bull, 0 cows

3. Enter a 4-digits number: 5123
0 bulls, 2 cows

4. Enter a 4-digits number: 5234
0 bulls, 2 cows

5. Enter a 4-digits number: 1634
0 bulls, 3 cows

6. Enter a 4-digits number: 1374
0 bulls, 3 cows

7. Enter a 4-digits number: 1348
1 bull, 3 cows

8. Enter a 4-digits number: 3418
4 bulls, 0 cows

Congratulations!!!! You found the code 3418.
```


## Other

I shouldn't give away this information.... but the command line interface for the game allows you to cheat... Type "cheat" (without quotes) instead of a number...

---

