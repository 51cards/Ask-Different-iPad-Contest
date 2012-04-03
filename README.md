# Introduction

In March-April 2012 Ask Different held a contest where the top contributors could earn iPads. However, there were only 5 iPads to give away, so when it turned out that there were more than 5 people in the top contribution bracket, it became necessary to break the tie. The people with the highest cumulative score of 35 non-closed non-deleted posts would be the winners.

Because this information wasn't immediately discernible on Ask Different, I created a script that would gather and display the necessary information.

# What the script does

* The script iterates through a hash of User ID/Name pairs, hitting the Stack Exchange API for the questions and answers since  1331856000 unix time, the start of the contest, written by that person.

* Each call to the API returns a list of the users's posts, each with an associated score. The script collects these scores into an array.

* The script sorts the array and stores the User ID, sum of all, the sum of the top 35, and the mean of the middle 5, in another array.

* Finally, when all the user data has been obtained from the API, it displays a list of the collected data sorted by the sum of the top 35 posts in descending order, and saves this information in a timestamped file.

# How to use it

Invoke the script like so:

    ruby contest.rb

This will produce output similar to what's below:

             gentmatt: 224 (5.00) (363/114)
               stuffe: 177 (3.40) (237/96)
       Mathias Bynens: 174 (4.00) (246/105)
             Daniel L: 171 (3.80) (191/49)
             jtbandes: 168 (4.00) (205/76)
          Kyle Cronin: 167 (4.00) (197/55)
               *bmike: 159 (3.80) (209/79)
        Adam Eberbach: 157 (3.00) (194/86)
               Ian C.: 152 (4.00) (160/47)
           Adam Davis: 145 (4.00) (208/113)
              *jaberg: 128 (2.20) (128/41)
             Senseful: 123 (3.00) (185/114)
           *jmlumpkin: 122 (3.20) (128/52)
                 *AJ.: 93 (2.20) (93/29)
             *Michiel: 92 (2.00) (101/75)
               *Hippo: 88 (2.00) (88/36)
    *Graeme Hutchison: 85 (2.20) (82/38)
          *penguinrob: 83 (3.00) (83/29)
              *KatieK: 81 (2.20) (81/35)
               *Moshe: 80 (2.00) (79/47)
         *Chris W Rea: 79 (3.60) (79/26)
                *R.M.: 74 (2.20) (74/30)
      *Andrew Larsson: 72 (4.20) (72/22)
         *Timothy M-H: 70 (2.00) (70/40)
              *patrix: 18 (3.20) (18/8)
         *Steve Moser: 12 (2.40) (12/6)
               *illep: 11 (2.20) (11/5)
               *jt703: 11 (2.20) (11/5)

The leftmost column is the username. Some usernames have been shortened to fit, such as "Timothy M-H" for the user "Timothy Mueller-Harder". Users with an asterisk preceding their name have completed level 2 but not level 3. Users without the asterisk have completed both levels.

The second column is the sum of the top 35 posts.

The third column, in parenthesis, is the mean of the middle 5 posts. This is useful to know what the "spread" of scores of the posts are - users with a high sum but low central mean have lower-scoring posts, but with a few that are very high-scoring.

The fourth column is the sum of all the posts made with the time period over the total number of posts.

The script will also output the same data to the results folder in the project with a date-stamped file. Note that earlier versions of the script produced data with fewer columns and users, so this is why earlier saved results appear to be missing some data.

Finally, you will see a line like

    requests left: 5801 of 10000

telling you how many remaining requests to the Stack Exchange API you are allowed to make. Note that the script must make at least two requests per user analyzed.
