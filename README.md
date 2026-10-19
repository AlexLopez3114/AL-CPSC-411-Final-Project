# Student Information

Alex Lopez
alopez31148@csu.fullerton.edu
884907866

# Project Name

Mr Gold's Portfolio

# Project Description

Throughout my childhood my brother and I have been avid collectors
of Lego, growing up I’ve become more interested in the pricing of our
various collected minifigures and Lego sets. Last year my brother
introduced me to a website called BrickLink, which acts as a similar website
like eBay but solely focused on Lego. This website tracks all lego
minifigures and pieces created, displaying current sellers and pricings for
select minifigures. A section of this website I am focusing on is the wanted
list where you can track all the minifigures you wish to buy, while also
selecting various settings such as amount, min & max pricing and
condition. The proposed system that I want to create is similar to this
feature, expanding upon it as a sort of tracker for the user’s current and
future collection of minifigures. My system is tailored towards two
demographics with the first being collectors wish to keep track of their
current inventory, viewing their counts and current conditions. On the other
hand, this app will be used to track how much specific minifigures are
currently being marketed for, and seeing if their pricings have altered within
a week period. When the user enters their current collection into the
system they will get detailed descriptions for each minifigures, and a total
count and pricing of their entire portfolio. In general, having a simplistic
application for a general assortment of Lego minifigures, and calculating
the market pricing of the minifigures I’ve collected.

# Screen List

1. HomeViewController
  1. Fully developed in storyboard
  2. Traversal buttons to go to the three major screens: Portfolio,
Search & Wanted List (Portfolio is the only one implemented so
far)
  3. Description of Milestone 1 within a UITextView
2. PortfolioViewController
  1. UITableView to display the names of all saved Minifigures within
the portfolio
  2. Includes various buttons to add new minifigures, edit existing
rows (only delete works at this stage), and a button to traverse
back to the Home screen
  3. General information displayed of current market values and
total price of entire portfolio (programmed in later Milestones)
3. AddViewController
  1. Takes in 5 different descriptions of a minifigure
  2. Uses all textbox information to declare a new minifigures object
and append to the existing array
  3. A lot of error control and descriptive comments to guild a user
to enter correct data on a minifigure
4. DetailsViewController
  1. Displays all of the saved information that was already set, or
created when the user added a new minifigure
  2. Button to traverse back to the portfolio, may cause issues with
data saving (incorporated in later Milestones)
  3.  Visual image of a new minifigure or a used minifigure (images
incorporated in later Milestones)
