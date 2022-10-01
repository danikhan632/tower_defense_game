# Tower Defense

#M5 Code Smells
https://docs.google.com/document/d/1DzOozj0WIgBDWqljivdWNNxGmG1cOwLHmlRzlKF39x8/edit?usp=sharing



This new update to M5 adds many new upgrades and unit testing

#Betül Arpinar

#TEST 1/2: test the name input

Unit test 1/2: tests whether the name input from the username textbox is valid or not.
The unit test group checks whether the name is too
short(less than 2 characters) or consists only of spaces.
I tried to test the null case however the textbox is
always initalized to "" so its impossible/redundant.
The test works as expected.

Name = "" => returns false as expected
Name = " " => returns false as expected
Name = "a" => returns false as expected
Name = "Betül" => returns true as expected
Name = "Daniyal" => returns true as expected
Name = "توفيق" => returns true as expected

Function works as expected and handles non-ASCII charachters well.
#TEST 3/4/5: Health Decrement

Checks whether health is decremented when an enemy hits the monument

Passes test if health decreases when enemy hits monument.
Tested for Easy, Medium, and Hard Levels.



#Test 6/7: Tests that difficutly affects the starting money

The unit test group tests that easier difficulties give the Player more money

'Easy' => $150
'Medium' => $100
'Hard' => $50
'Nightmare' => error thrown and caught successfully

The code functions as expected and ensures that difficulty affects the player's wallet.
No potential for any issues.

The unit test group tests that easier difficulties give the Player more money

'Easy' => 75
'Medium' => 50
'Hard' => 25
'Nightmare' => error thrown and caught successfully

This calculation is done using the number for wallet and since the wallet code runs
perfectly, I have little reason to believe that the health code could break
The code functions as expected and ensures that difficulty affects the player's wallet.
No potential for any issues.


Test 8
This test determines the aggregate damage that current towers can do in the medium mode of the game.

Test 9, 10
This test determines whether the final boss health when all enemies are defeated in the easy and medium difficulties is accurate.

#Arhum Khan (Daniyal Khan's little brother)
#Test 11/12/13: Tests game over functionality for Easy, Medium, Hard based on monument health hitting 0.

Test 14
This test determines the aggregate damage that current towers can do in the medium mode of the game.

توفيق محمد#

#Tests 15/16 Tests whether add functionality adds enemy to canvas AND enemyList

#Test 17/18: Tests that the inital objects are loaded
into the canvas when the game starts

These intial components include checking whether the first <Enemy>, <Tower>,
and necessary TextComponents are loaded into the canvas.
Because these components are sprite data they called
int the onLoad() async method so they're placement can
cause issues

Test 1: Tests whether all six components are
rendering in the main canvas. Six components are expected
expected = 6 | Actual = 6

Test 2: Tests whether the first enemy component is loaded and
rendering in the main canvas. Since this is called from the
SpriteSheet, memory access is minimized.

expected = 1 | Actual = 1

Test 3: Tests whether the first Tower component is loaded and
rendering in the main canvas. Still unclear whether
monument should be its own unique type of object since
it has twin mini-guns that will be implented M4

expected = 1 | Actual = 1



Tests the cost of all towers at all difficulties
These costs are displayed in the side menu and
come from the inital diffculty number passed in

Easy:
Gun Tower = $16
Missile Tower = $33
Laser Tower = $50

Medium:
Gun Tower = $25
Missile Tower = $50
Laser Tower = $75

Hard:
Gun Tower = $50
Missile Tower = $100
Laser Tower = $150

  
Test 19:
This test determines the aggregate damage that current towers can do in the hard mode of the game.
  
Test 20:
This test determines whether the final boss health when all enemies are defeated in the hard difficulty is accurate.
  
Test 21:
 This Test determines whether the upgrade of the tower does more damage to enemies in easy mode.


#Tawfiq Aliu

#Test 22/23
This is a massive test grouping that tests the functionallity of
side menu store such as buying/placing tower. It checks whether
the wallet has been properly decremented and account for
resolution scalling for 1280x720, 1600x900, 1920x1080.
Prevents buying towers if there is insufficent funds.
  

#Test 24/25/26
Amount of hits before game over changes based on difficulty
Easy is 15, Medium is 10, Hard is 5
  
#Test 27/28/29
These group of tests test the functionality of the mechanism that determines whether an enemy was hit or not.
It uses the status of the first enemy to test this and determines that status of this enemy at the initial phase of the game. 
These tests cover the difficulties easy, medium, and hard.
  
 Test 30, 31:
  This Test determines whether the upgrade of the tower does more damage to enemies in medium and hard mode.
#Daniyal Khan(Arhum's Older Brother)
#Test 30/31
Passes in Vector2 coordinate objects and calls the
bool onPath() Method. Check whether given points are
on the path or not on the path.
It also tests each point to account resolution
scalling for 1280x720, 1600x900, 1920x1080.

This check is important to ensure the game works properly
on different resolution devices.

#Test 32/33
Tests whether first instance of enemy added to list is removed.
  
#Test 34/35
 Tests whether range of tower to shoot at is accurate for easy and medium difficulties.

#Daniyal Khan(Arhum's Older Brother)
  
#Test 36/37
Passes in Vector2 coordinate objects and calls the
bool onPath() Method. Check whether given points are
on the path or not on the path.
It also tests each point to account resolution
scalling for 1280x720, 1600x900, 1920x1080.

#Test 38/39
  

This check is important to ensure the game works properly
on different resolution devices.
  
#Test 40/41/42
 Checks to see if upgrade price is correct for easy, medium, hard difficulty
#Test 43
 Tests whether range of tower to shoot at is accurate for hard difficulty
  

  
  
 


