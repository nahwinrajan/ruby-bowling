#Readme

#usage
- open your terminal window
- navigate to un-compressed / un-zipped folder
- type the followin in your terminal: "ruby main.rb"
- Example input: 
    - [6,2],[9,1],[10, 1],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]
    - [[10], [10], [10], [10], [10], [10], [10], [10], [10], [10,10,10]]

- the latter is example of perfect score.

## Integration Test
I'm aware that I didn't write Integration test (testing the behaviour of the program when It is run on the terminal windows) due to I want the program to run in
terminal window only and couldn't find documentation of rspec for integration test on terminal window.

## usage of rspec
I'm not used to rspec and literally just used it first time for this sample program
this being said. it is fun to learn another stuff regarding ruby and it should serve
to point out that tools can be learn about.

## Scoring
Bonus only given for a Strike, spare does not gain bonus points

## Known Bug
- if you enter: [[6,2],[9,1],[10, 1],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]]
the input will be accept but on the 3rd element of the main array I'll only take the first value
-- this is due to my current regular expression.
