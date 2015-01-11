# Data Globe

A simple rails application for visualizing data on a 3D planet earth. 

Demo on [Heroku](https://still-spire-52959.herokuapp.com)

### Setup

No extra setup needed. Simply download the source code, `bundle install`, `rake db:migrate`, you know the drill.

### Feature

This application allows for batch importing as well as manually entering and adjusting data. Changes will be reflected on the canvas immediately.

![screenshot](https://github.com/marwei/data-globe/blob/master/screenshot/screenshot.jpg)

#### Import

To import, the file must be in csv format with four columns. The column names are (from left to right) "city", "state", "country", "count" (all lower cases).

### Credit

* [Geocoder](https://github.com/alexreisner/geocoder)

* [Webgl-globe](https://github.com/dataarts/webgl-globe)

* [Three.js](https://github.com/mrdoob/three.js/)