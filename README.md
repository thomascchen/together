![Imgur](http://i.imgur.com/WVffsUW.png)

![Build Status](https://codeship.com/projects/c09887b0-04b6-0133-8447-52ca95efad4a/status?branch=master) [![Code Climate](https://codeclimate.com/github/thomascchen/together.png)](https://codeclimate.com/github/thomascchen/together) [![Test Coverage](https://codeclimate.com/github/thomascchen/together/badges/coverage.svg)](https://codeclimate.com/github/thomascchen/together/coverage)

## About
**Together** is a tenant organizing app that helps tenants identify problems in their apartment building and find solutions to those problems with the help of their neighbors. Housing inequality has been a big focus of my academic and volunteer work, and I wanted to build something that helped city dwellers address some of the common issues that come up in apartment buildings, especially when dealing with an irresponsible or absentee landlord.

## Website and Logging In
[http://tenants-together.herokuapp.com](http://tenants-together.herokuapp.com)

If you'd like to explore the app without creating an account, please use the following credentials:

**email:** guest@example.com
**password:** password

## How It Works
- Users can report any kind of problem they're facing in the building or with their landlord and document it with an optional photograph, which uses [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) and Amazon Web Services for image uploading.

![Imgur](http://i.imgur.com/KYFEV6Q.png)

- Other people in the building can view details about each problem and propose solutions.

![Imgur](http://i.imgur.com/4ABJmLB.png)

- Users can accept a solution to a problem they submitted by clicking "Accept Solution." This marks the solution as accepted and the problem as solved. Solved Problems are moved out of the main page and into the Solved Problems page which serves as a record of activity in the building over time.

![Imgur](http://i.imgur.com/mfLMKLp.png)

- I used jQuery and Ajax to create a +1 upvote button, which lets users show that they think a problem is important or that they agree with a solution.

![Imgur](http://i.imgur.com/i79oZDr.gif)

- I used [HighCharts JS](https://github.com/highslide-software/highcharts.com) to create data visualizations that give users a higher level view of the problems in the building broken out by category and a leaderboard of user contributions.

![Imgur](http://i.imgur.com/mBijY3C.gif)

- I wrote custom SQL queries to sort Problems and Solutions. Open Problems are ordered first by urgency, then by time last updated, and finally by number of upvotes. Solutions are ordered first by number of upvotes and second by time last updated. Solved Problems are ordered by when they were solved.
- I applied [Material Design](http://www.google.com/design/spec/material-design/introduction.html) principles to the front end using [Foundation](http://foundation.zurb.com/) and custom SASS and CSS.
- A welcome modal launches on the main page after the first login, using [js-cookie](https://github.com/js-cookie/js-cookie). For demonstration purposes, I've set the browser cookie to reset once a day.  

## ERD
![Imgur](http://i.imgur.com/urJmHdO.png)

## Download
```
git clone https://github.com/thomascchen/together.git
cd together
bundle install
rake db:create db:migrate db:seed
```

## Contribute
Please open an issue to discuss any potential changes/additions.
